import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllergiesScreen extends StatefulWidget {
  const AllergiesScreen({super.key});

  @override
  State<AllergiesScreen> createState() => _AllergiesScreenState();
}

class _AllergiesScreenState extends State<AllergiesScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  List<Allergy> allergies = [
    Allergy(
      name: "Penicillin",
      category: "Medication",
      severity: "Severe",
      symptoms: "Rash, difficulty breathing, swelling",
      triggers: "Any penicillin-based antibiotics",
      treatment: "Epinephrine auto-injector, immediate medical attention",
      diagnosedDate: "Jan 2020",
      notes: "Carry EpiPen at all times. Inform all healthcare providers.",
      isActive: true,
    ),
    Allergy(
      name: "Shellfish",
      category: "Food",
      severity: "Moderate",
      symptoms: "Hives, nausea, stomach cramps",
      triggers: "Shrimp, crab, lobster, mussels",
      treatment: "Antihistamines, avoid trigger foods",
      diagnosedDate: "Mar 2018",
      notes: "Check restaurant menus carefully. Read food labels.",
      isActive: true,
    ),
    Allergy(
      name: "Pollen",
      category: "Environmental",
      severity: "Mild",
      symptoms: "Sneezing, runny nose, itchy eyes",
      triggers: "Tree pollen, grass pollen (spring/summer)",
      treatment: "Antihistamines, nasal spray",
      diagnosedDate: "Childhood",
      notes: "Seasonal allergy, worse in spring and early summer.",
      isActive: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Allergies",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () => _showAddAllergyDialog(),
            icon: const Icon(Icons.add, color: Colors.blue),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAllergyOverview(),
              const SizedBox(height: 20),
              _buildEmergencyCard(),
              const SizedBox(height: 20),
              _buildAllergiesList(),
              const SizedBox(height: 20),
              _buildAllergyTips(),
              const SizedBox(height: 20),
              _buildSeasonalAlert(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddAllergyDialog(),
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildAllergyOverview() {
    Map<String, int> categoryCounts = {};
    for (var allergy in allergies.where((a) => a.isActive)) {
      categoryCounts[allergy.category] =
          (categoryCounts[allergy.category] ?? 0) + 1;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange[400]!, Colors.red[400]!],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Text(
                "Allergy Overview",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildOverviewCard(
                  "Total Allergies",
                  "${allergies.where((a) => a.isActive).length}",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildOverviewCard(
                  "Severe",
                  "${allergies.where((a) => a.severity == 'Severe' && a.isActive).length}",
                ),
              ),
            ],
          ),
          if (categoryCounts.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children:
                  categoryCounts.entries.map((entry) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "${entry.key}: ${entry.value}",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOverviewCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyCard() {
    bool hasSevereAllergies = allergies.any(
      (a) => a.severity == 'Severe' && a.isActive,
    );

    if (!hasSevereAllergies) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red[300]!, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.emergency, color: Colors.red[600], size: 24),
              const SizedBox(width: 8),
              Text(
                "Emergency Alert",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "You have severe allergies that require immediate medical attention. Always carry your emergency medication.",
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.red[600]),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.phone, size: 16),
                  label: const Text("Call 911"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[600],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.medical_services, size: 16),
                  label: const Text("Emergency Kit"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[600],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAllergiesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Allergies",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        if (allergies.isEmpty)
          _buildEmptyState()
        else
          ...allergies.map((allergy) => _buildAllergyCard(allergy)).toList(),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.healing_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            "No Allergies Recorded",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Add your allergies to keep track of triggers and treatments",
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAllergyCard(Allergy allergy) {
    Color severityColor = _getSeverityColor(allergy.severity);
    IconData categoryIcon = _getCategoryIcon(allergy.category);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border:
            allergy.severity == 'Severe'
                ? Border.all(color: Colors.red[300]!, width: 2)
                : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: severityColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(categoryIcon, color: severityColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            allergy.name,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: severityColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            allergy.severity.toUpperCase(),
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: severityColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${allergy.category} • Diagnosed: ${allergy.diagnosedDate}",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert, color: Colors.grey),
                itemBuilder:
                    (context) => [
                      PopupMenuItem(
                        child: const Text("Edit"),
                        onTap: () => _showEditAllergyDialog(allergy),
                      ),
                      PopupMenuItem(
                        child: const Text("Delete"),
                        onTap: () => _deleteAllergy(allergy),
                      ),
                    ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildAllergySection(
            "Symptoms",
            allergy.symptoms,
            Icons.sick,
            Colors.red,
          ),
          const SizedBox(height: 8),
          _buildAllergySection(
            "Triggers",
            allergy.triggers,
            Icons.warning_amber,
            Colors.orange,
          ),
          const SizedBox(height: 8),
          _buildAllergySection(
            "Treatment",
            allergy.treatment,
            Icons.medical_services,
            Colors.green,
          ),
          if (allergy.notes.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.note, color: Colors.blue, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      allergy.notes,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                allergy.isActive ? Icons.circle : Icons.circle_outlined,
                color: allergy.isActive ? Colors.green : Colors.grey,
                size: 12,
              ),
              const SizedBox(width: 4),
              Text(
                allergy.isActive ? "Active" : "Inactive",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: allergy.isActive ? Colors.green : Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAllergySection(
    String title,
    String content,
    IconData icon,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
              Text(
                content,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAllergyTips() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lightbulb_outline, color: Colors.blue, size: 24),
              const SizedBox(width: 8),
              Text(
                "Allergy Management Tips",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTipItem(
            "🏷️",
            "Read labels carefully",
            "Always check ingredient lists on food and medication labels",
          ),
          _buildTipItem(
            "💊",
            "Carry emergency medication",
            "Keep antihistamines or EpiPens accessible at all times",
          ),
          _buildTipItem(
            "👨‍⚕️",
            "Inform healthcare providers",
            "Tell all doctors and dentists about your allergies",
          ),
          _buildTipItem(
            "🆔",
            "Wear medical ID",
            "Consider wearing a medical alert bracelet or necklace",
          ),
          _buildTipItem(
            "📱",
            "Use allergy apps",
            "Track symptoms and identify patterns with allergy tracking apps",
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem(String emoji, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
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
    );
  }

  Widget _buildSeasonalAlert() {
    bool hasEnvironmentalAllergies = allergies.any(
      (a) => a.category == 'Environmental' && a.isActive,
    );

    if (!hasEnvironmentalAllergies) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.eco, color: Colors.green[600], size: 24),
              const SizedBox(width: 8),
              Text(
                "Seasonal Allergy Alert",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Spring pollen season is approaching. Consider starting preventive treatment and monitoring pollen counts.",
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.green[600]),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.cloud, size: 16),
            label: const Text("Check Pollen Forecast"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[600],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'mild':
        return Colors.green;
      case 'moderate':
        return Colors.orange;
      case 'severe':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return Icons.restaurant;
      case 'medication':
        return Icons.medication;
      case 'environmental':
        return Icons.eco;
      case 'insect':
        return Icons.bug_report;
      default:
        return Icons.warning;
    }
  }

  void _showAddAllergyDialog() {
    _showAllergyDialog();
  }

  void _showEditAllergyDialog(Allergy allergy) {
    _showAllergyDialog(allergy: allergy);
  }

  void _showAllergyDialog({Allergy? allergy}) {
    final nameController = TextEditingController(text: allergy?.name ?? '');
    final symptomsController = TextEditingController(
      text: allergy?.symptoms ?? '',
    );
    final triggersController = TextEditingController(
      text: allergy?.triggers ?? '',
    );
    final treatmentController = TextEditingController(
      text: allergy?.treatment ?? '',
    );
    final notesController = TextEditingController(text: allergy?.notes ?? '');
    String selectedCategory = allergy?.category ?? 'Food';
    String selectedSeverity = allergy?.severity ?? 'Mild';
    bool isActive = allergy?.isActive ?? true;

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setState) => AlertDialog(
                  title: Text(
                    allergy == null ? "Add Allergy" : "Edit Allergy",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: "Allergy Name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: selectedCategory,
                                decoration: const InputDecoration(
                                  labelText: "Category",
                                  border: OutlineInputBorder(),
                                ),
                                items:
                                    [
                                      'Food',
                                      'Medication',
                                      'Environmental',
                                      'Insect',
                                      'Other',
                                    ].map((category) {
                                      return DropdownMenuItem(
                                        value: category,
                                        child: Text(category),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedCategory = value!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: selectedSeverity,
                                decoration: const InputDecoration(
                                  labelText: "Severity",
                                  border: OutlineInputBorder(),
                                ),
                                items:
                                    ['Mild', 'Moderate', 'Severe'].map((
                                      severity,
                                    ) {
                                      return DropdownMenuItem(
                                        value: severity,
                                        child: Text(severity),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedSeverity = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: symptomsController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: "Symptoms",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: triggersController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: "Triggers",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: treatmentController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: "Treatment",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: notesController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: "Notes (Optional)",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SwitchListTile(
                          title: const Text("Active Allergy"),
                          value: isActive,
                          onChanged: (value) {
                            setState(() {
                              isActive = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isNotEmpty) {
                          final newAllergy = Allergy(
                            name: nameController.text,
                            category: selectedCategory,
                            severity: selectedSeverity,
                            symptoms: symptomsController.text,
                            triggers: triggersController.text,
                            treatment: treatmentController.text,
                            diagnosedDate: allergy?.diagnosedDate ?? "Today",
                            notes: notesController.text,
                            isActive: isActive,
                          );

                          setState(() {
                            if (allergy == null) {
                              allergies.add(newAllergy);
                            } else {
                              final index = allergies.indexOf(allergy);
                              allergies[index] = newAllergy;
                            }
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: Text(allergy == null ? "Add" : "Save"),
                    ),
                  ],
                ),
          ),
    );
  }

  void _deleteAllergy(Allergy allergy) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              "Delete Allergy",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            content: Text(
              "Are you sure you want to delete ${allergy.name}?",
              style: GoogleFonts.poppins(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    allergies.remove(allergy);
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }
}

class Allergy {
  final String name;
  final String category;
  final String severity;
  final String symptoms;
  final String triggers;
  final String treatment;
  final String diagnosedDate;
  final String notes;
  final bool isActive;

  Allergy({
    required this.name,
    required this.category,
    required this.severity,
    required this.symptoms,
    required this.triggers,
    required this.treatment,
    required this.diagnosedDate,
    required this.notes,
    required this.isActive,
  });
}
