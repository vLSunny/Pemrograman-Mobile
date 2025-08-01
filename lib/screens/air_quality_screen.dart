import 'package:flutter/material.dart';
import 'package:air_quality/air_quality.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:io';

class AirQualityScreen extends StatefulWidget {
  const AirQualityScreen({super.key});

  @override
  State<AirQualityScreen> createState() => _AirQualityScreenState();
}

class _AirQualityScreenState extends State<AirQualityScreen> {
  final AirQuality airQuality = AirQuality(
    '7339c787e3693ce2e63536eb02894cdab1c2c8e5',
  );
  AirQualityData? airQualityData;
  bool isLoading = false;
  String? error;
  bool isRetrying = false;
  Timer? _retryTimer;

  @override
  void initState() {
    super.initState();
    fetchAirQuality();
  }

  @override
  void dispose() {
    _retryTimer?.cancel();
    super.dispose();
  }

  Future<void> fetchAirQuality({bool isRetry = false}) async {
    if (isRetry) {
      setState(() => isRetrying = true);
    } else {
      setState(() {
        isLoading = true;
        error = null;
      });
    }

    try {
      const double latitude = -6.2088;
      const double longitude = 106.8456;

      final data = await _fetchWithTimeout(
        () => airQuality.feedFromGeoLocation(latitude, longitude),
        timeout: const Duration(seconds: 15),
      );

      setState(() {
        airQualityData = data;
        isLoading = false;
        isRetrying = false;
        error = null;
      });
    } catch (e) {
      final errorMessage = _getErrorMessage(e);
      setState(() {
        error = errorMessage;
        isLoading = false;
        isRetrying = false;
      });
    }
  }

  Future<T> _fetchWithTimeout<T>(
    Future<T> Function() fetchFunction, {
    required Duration timeout,
  }) async {
    try {
      return await fetchFunction().timeout(timeout);
    } on TimeoutException {
      throw Exception(
        'Request timeout. Please check your internet connection.',
      );
    } on SocketException catch (e) {
      if (e.message.contains('Failed host lookup')) {
        throw Exception(
          'Unable to connect to air quality service. Please check your internet connection.',
        );
      }
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Error fetching data: ${e.toString()}');
    }
  }

  String _getErrorMessage(dynamic error) {
    final errorStr = error.toString().toLowerCase();

    if (errorStr.contains('socketexception') ||
        errorStr.contains('failed host lookup')) {
      return 'Unable to connect to air quality service. Please check your internet connection and try again.';
    } else if (errorStr.contains('timeout')) {
      return 'Request timeout. Please check your internet connection and try again.';
    } else if (errorStr.contains('clientexception')) {
      return 'Network connection error. Please check your internet connection.';
    } else if (errorStr.contains('404') || errorStr.contains('not found')) {
      return 'Air quality data not available for this location.';
    } else {
      return 'Error loading air quality data. Please try again.';
    }
  }

  void _startRetryTimer() {
    _retryTimer?.cancel();
    int retryCount = 0;

    _retryTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (retryCount >= 3) {
        timer.cancel();
        return;
      }

      fetchAirQuality(isRetry: true);
      retryCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Air Quality',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: fetchAirQuality,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(),
              const SizedBox(height: 20),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (error != null)
                _buildErrorCard()
              else if (airQualityData != null)
                _buildAirQualityCard()
              else
                const Center(child: Text('No data available')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Air Quality',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Real-time air quality data for your location',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAirQualityCard() {
    if (airQualityData == null) return const SizedBox.shrink();

    final data = airQualityData!;
    final aqi = data.airQualityIndex;

    // Extract city and time from the data object if available
    String? city;
    String? time;

    try {
      // These might be available as properties or we might need to use the location name
      city = 'Jakarta'; // Default location since we're using fixed coordinates
      time = DateTime.now().toString().substring(0, 16); // Current time
    } catch (e) {
      city = null;
      time = null;
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (city != null)
              Text(
                'Location: $city',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            const SizedBox(height: 16),
            _buildQualityIndicator(aqi),
            if (time != null) ...[
              const SizedBox(height: 8),
              Text(
                'Last updated: $time',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildQualityIndicator(int? aqi) {
    if (aqi == null) return const Text('AQI: N/A');

    Color color;
    String status;
    String description;

    if (aqi <= 50) {
      color = Colors.green;
      status = 'Good';
      description = 'Air quality is satisfactory';
    } else if (aqi <= 100) {
      color = Colors.yellow;
      status = 'Moderate';
      description = 'Air quality is acceptable';
    } else if (aqi <= 150) {
      color = Colors.orange;
      status = 'Unhealthy for Sensitive Groups';
      description = 'Sensitive individuals may experience health effects';
    } else if (aqi <= 200) {
      color = Colors.red;
      status = 'Unhealthy';
      description = 'Everyone may begin to experience health effects';
    } else if (aqi <= 300) {
      color = Colors.purple;
      status = 'Very Unhealthy';
      description =
          'Health alert: everyone may experience more serious health effects';
    } else {
      color = Colors.brown;
      status = 'Hazardous';
      description = 'Health warning of emergency conditions';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Text(
              'AQI: $aqi',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          status,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        Text(
          description,
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildErrorCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(_getErrorIcon(), color: _getErrorColor(), size: 48),
            const SizedBox(height: 16),
            Text(
              _getErrorTitle(),
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error ?? 'An unexpected error occurred',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (isRetrying)
              const Column(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(height: 8),
                  Text('Retrying...'),
                ],
              )
            else ...[
              ElevatedButton.icon(
                onPressed: fetchAirQuality,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _startRetryTimer,
                child: const Text('Auto-retry in 3 seconds'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getErrorIcon() {
    if (error?.toLowerCase().contains('internet') == true ||
        error?.toLowerCase().contains('network') == true ||
        error?.toLowerCase().contains('socketexception') == true) {
      return Icons.wifi_off;
    } else if (error?.toLowerCase().contains('timeout') == true) {
      return Icons.timer_off;
    } else {
      return Icons.error_outline;
    }
  }

  Color _getErrorColor() {
    if (error?.toLowerCase().contains('internet') == true ||
        error?.toLowerCase().contains('network') == true ||
        error?.toLowerCase().contains('socketexception') == true) {
      return Colors.orange;
    } else if (error?.toLowerCase().contains('timeout') == true) {
      return Colors.amber;
    } else {
      return Colors.red;
    }
  }

  String _getErrorTitle() {
    if (error?.toLowerCase().contains('internet') == true ||
        error?.toLowerCase().contains('network') == true ||
        error?.toLowerCase().contains('socketexception') == true) {
      return 'Connection Error';
    } else if (error?.toLowerCase().contains('timeout') == true) {
      return 'Request Timeout';
    } else {
      return 'Error Loading Data';
    }
  }
}
