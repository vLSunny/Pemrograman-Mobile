import 'package:flutter/material.dart';
import 'package:air_quality/air_quality.dart';
import 'package:google_fonts/google_fonts.dart';

class AirQualityScreen extends StatefulWidget {
  const AirQualityScreen({super.key});

  @override
  State<AirQualityScreen> createState() => _AirQualityScreenState();
}

class _AirQualityScreenState extends State<AirQualityScreen> {
  final AirQuality airQuality = AirQuality(
    '7339c787e3693ce2e63536eb02894cdab1c2c8e5',
  );
  Map<String, dynamic>? airQualityData;
  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchAirQuality();
  }

  Future<void> fetchAirQuality() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      const double latitude = -6.2088;
      const double longitude = 106.8456;

      final data = await airQuality.feedFromGeoLocation(latitude, longitude);

      setState(() {
        airQualityData = data as Map<String, dynamic>?;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
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
    final aqi = data['aqi'] as int?;
    final city = data['city'] as String?;
    final time = data['time'] as String?;

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
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(
              'Error loading air quality data',
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
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: fetchAirQuality,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
