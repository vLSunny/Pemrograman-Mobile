import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_model.dart';
import '../services/user_storage_service.dart';
import 'home_screen.dart';

class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({super.key});

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  // Form data
  String _selectedGender = 'Pria';
  String _selectedActivityLevel = 'Sedang';
  String _selectedFitnessGoal = 'Mempertahankan Berat Badan';

  int _currentPage = 0;
  bool _isLoading = false;

  final List<String> _genderOptions = ['Pria', 'Wanita'];
  final List<String> _activityLevels = ['Rendah', 'Sedang', 'Tinggi'];
  final List<String> _fitnessGoals = [
    'Menurunkan Berat Badan',
    'Menambah Berat Badan',
    'Mempertahankan Berat Badan',
    'Membangun Otot',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _submitRegistration() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        age: int.parse(_ageController.text.trim()),
        height: double.parse(_heightController.text.trim()),
        weight: double.parse(_weightController.text.trim()),
        gender: _selectedGender,
        activityLevel: _selectedActivityLevel,
        fitnessGoal: _selectedFitnessGoal,
      );

      await UserStorageService.saveUser(user);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registrasi berhasil! Selamat datang!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registrasi gagal: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading:
            _currentPage > 0
                ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: _previousPage,
                )
                : null,
        title: Text(
          'Registrasi Pengguna',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Progress indicator
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: List.generate(3, (index) {
                  return Expanded(
                    child: Container(
                      height: 4,
                      margin: EdgeInsets.only(right: index < 2 ? 8 : 0),
                      decoration: BoxDecoration(
                        color:
                            index <= _currentPage
                                ? const Color(0xFF92A3FD)
                                : Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: [
                  _buildPersonalInfoPage(),
                  _buildPhysicalInfoPage(),
                  _buildGoalsPage(),
                ],
              ),
            ),

            // Navigation buttons
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _previousPage,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: Color(0xFF92A3FD)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Kembali',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF92A3FD),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  if (_currentPage > 0) const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                          _isLoading
                              ? null
                              : (_currentPage == 2
                                  ? _submitRegistration
                                  : _nextPage),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF92A3FD),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child:
                          _isLoading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : Text(
                                _currentPage == 2 ? 'Selesai' : 'Lanjut',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Personal',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Mari kenalan terlebih dahulu!',
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 32),

          // Name field
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Nama Lengkap',
              hintText: 'Masukkan nama lengkap Anda',
              prefixIcon: const Icon(Icons.person, color: Color(0xFF92A3FD)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Nama tidak boleh kosong';
              }
              if (value.length < 2) {
                return 'Nama minimal 2 karakter';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Age field
          TextFormField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Umur',
              hintText: 'Masukkan umur Anda',
              prefixIcon: const Icon(Icons.cake, color: Color(0xFF92A3FD)),
              suffixText: 'tahun',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Umur tidak boleh kosong';
              }
              final age = int.tryParse(value);
              if (age == null || age < 10 || age > 100) {
                return 'Umur harus antara 10-100 tahun';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Gender selection
          Text(
            'Jenis Kelamin',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children:
                _genderOptions.map((gender) {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        right: gender == _genderOptions.first ? 8 : 0,
                        left: gender == _genderOptions.last ? 8 : 0,
                      ),
                      child: InkWell(
                        onTap: () => setState(() => _selectedGender = gender),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color:
                                _selectedGender == gender
                                    ? const Color(0xFF92A3FD)
                                    : Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  _selectedGender == gender
                                      ? const Color(0xFF92A3FD)
                                      : Colors.grey[300]!,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                gender == 'Pria' ? Icons.male : Icons.female,
                                color:
                                    _selectedGender == gender
                                        ? Colors.white
                                        : Colors.grey[600],
                              ),
                              const SizedBox(width: 8),
                              Text(
                                gender,
                                style: GoogleFonts.poppins(
                                  color:
                                      _selectedGender == gender
                                          ? Colors.white
                                          : Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPhysicalInfoPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Fisik',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Bantu kami menghitung kebutuhan kalori Anda',
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 32),

          // Height field
          TextFormField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Tinggi Badan',
              hintText: 'Masukkan tinggi badan Anda',
              prefixIcon: const Icon(Icons.height, color: Color(0xFF92A3FD)),
              suffixText: 'cm',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Tinggi badan tidak boleh kosong';
              }
              final height = double.tryParse(value);
              if (height == null || height < 100 || height > 250) {
                return 'Tinggi badan harus antara 100-250 cm';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Weight field
          TextFormField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Berat Badan',
              hintText: 'Masukkan berat badan Anda',
              prefixIcon: const Icon(
                Icons.monitor_weight,
                color: Color(0xFF92A3FD),
              ),
              suffixText: 'kg',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Berat badan tidak boleh kosong';
              }
              final weight = double.tryParse(value);
              if (weight == null || weight < 30 || weight > 300) {
                return 'Berat badan harus antara 30-300 kg';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Activity level selection
          Text(
            'Tingkat Aktivitas',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children:
                _activityLevels.map((level) {
                  String description = '';
                  switch (level) {
                    case 'Rendah':
                      description = 'Jarang berolahraga, aktivitas ringan';
                      break;
                    case 'Sedang':
                      description = 'Olahraga 3-5 kali seminggu';
                      break;
                    case 'Tinggi':
                      description = 'Olahraga intensif 6-7 kali seminggu';
                      break;
                  }

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap:
                          () => setState(() => _selectedActivityLevel = level),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              _selectedActivityLevel == level
                                  ? const Color(0xFF92A3FD).withOpacity(0.1)
                                  : Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                _selectedActivityLevel == level
                                    ? const Color(0xFF92A3FD)
                                    : Colors.grey[300]!,
                          ),
                        ),
                        child: Row(
                          children: [
                            Radio<String>(
                              value: level,
                              groupValue: _selectedActivityLevel,
                              onChanged:
                                  (value) => setState(
                                    () => _selectedActivityLevel = value!,
                                  ),
                              activeColor: const Color(0xFF92A3FD),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    level,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    description,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tujuan Fitness',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Apa tujuan utama Anda?',
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 32),

          Column(
            children:
                _fitnessGoals.map((goal) {
                  IconData icon;
                  String description = '';

                  switch (goal) {
                    case 'Menurunkan Berat Badan':
                      icon = Icons.trending_down;
                      description = 'Fokus pada defisit kalori dan cardio';
                      break;
                    case 'Menambah Berat Badan':
                      icon = Icons.trending_up;
                      description = 'Fokus pada surplus kalori dan protein';
                      break;
                    case 'Mempertahankan Berat Badan':
                      icon = Icons.balance;
                      description = 'Menjaga keseimbangan kalori';
                      break;
                    case 'Membangun Otot':
                      icon = Icons.fitness_center;
                      description = 'Fokus pada latihan kekuatan dan protein';
                      break;
                    default:
                      icon = Icons.flag;
                  }

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: InkWell(
                      onTap: () => setState(() => _selectedFitnessGoal = goal),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color:
                              _selectedFitnessGoal == goal
                                  ? const Color(0xFF92A3FD).withOpacity(0.1)
                                  : Colors.grey[50],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color:
                                _selectedFitnessGoal == goal
                                    ? const Color(0xFF92A3FD)
                                    : Colors.grey[300]!,
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color:
                                    _selectedFitnessGoal == goal
                                        ? const Color(0xFF92A3FD)
                                        : Colors.grey[300],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                icon,
                                color:
                                    _selectedFitnessGoal == goal
                                        ? Colors.white
                                        : Colors.grey[600],
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    goal,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    description,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (_selectedFitnessGoal == goal)
                              const Icon(
                                Icons.check_circle,
                                color: Color(0xFF92A3FD),
                                size: 24,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),

          const SizedBox(height: 32),

          // Summary card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF92A3FD).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF92A3FD).withOpacity(0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ringkasan Profil',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Nama: ${_nameController.text.isNotEmpty ? _nameController.text : "-"}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  'Umur: ${_ageController.text.isNotEmpty ? "${_ageController.text} tahun" : "-"}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  'Tinggi: ${_heightController.text.isNotEmpty ? "${_heightController.text} cm" : "-"}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  'Berat: ${_weightController.text.isNotEmpty ? "${_weightController.text} kg" : "-"}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  'Jenis Kelamin: $_selectedGender',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  'Aktivitas: $_selectedActivityLevel',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  'Tujuan: $_selectedFitnessGoal',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
