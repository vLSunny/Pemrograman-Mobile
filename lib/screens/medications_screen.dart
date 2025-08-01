import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicationsScreen extends StatefulWidget {
  const MedicationsScreen({super.key});

  @override
  State<MedicationsScreen> createState() => _MedicationsScreenState();
}

class _MedicationsScreenState extends State<MedicationsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  List<Medication> medications = [
    Medication(
      name: "Lisinopril",
      dosage: "10mg",
      frequency: "Once daily",
      timeOfDay: "Morning",
      prescribedBy: "Dr. Sarah Johnson",
      startDate: "Jan 15, 2024",
      endDate: "Ongoing",
      isActive: true,
      notes: "Take with food. Monitor blood pressure.",
      sideEffects: "Dizziness, dry cough",
      reminderEnabled: true,
    ),
    Medication(
      name: "Metformin",
      dosage: "500mg",
      frequency: "Twice daily",
      timeOfDay: "Morning & Evening",
      prescribedBy: "Dr. Michael Brown",
      startDate: "Mar 10, 2024",
      endDate: "Ongoing",
      isActive: true,
      notes: "Take with meals to reduce stomach upset.",
      sideEffects: "Nausea, stomach upset",
      reminderEnabled: true,
    ),
    Medication(
      name: "Vitamin D3",
      dosage: "1000 IU",
      frequency: "Once daily",
      timeOfDay: "Morning",
      prescribedBy: "Self-prescribed",
      startDate: "Feb 1, 2024",
      endDate: "Ongoing",
      isActive: true,
      notes: "Supplement for bone health.",
      sideEffects: "None reported",
      reminderEnabled: false,
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
          "Medications",
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
            onPressed: () => _showAddMedicationDialog(),
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
              _buildMedicationOverview(),
              const SizedBox(height: 20),
              _buildTodaysSchedule(),
              const SizedBox(height: 20),
              _buildMedicationsList(),
              const SizedBox(height: 20),
              _buildMedicationTips(),
              const SizedBox(height: 20),
              _buildInteractionWarning(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMedicationDialog(),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildMedicationOverview() {
    int activeMedications = medications.where((m) => m.isActive).length;
    int remindersEnabled = medications.where((m) => m.reminderEnabled).length;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[400]!, Colors.purple[400]!],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
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
              const Icon(Icons.medication, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Text(
                "Medication Overview",
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
                  "Active Medications",
                  "$activeMedications",
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildOverviewCard("Reminders Set", "$remindersEnabled"),
              ),
            ],
          ),
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

  Widget _buildTodaysSchedule() {
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
              const Icon(Icons.schedule, color: Colors.green, size: 24),
              const SizedBox(width: 8),
              Text(
                "Today's Schedule",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildScheduleItem("8:00 AM", "Lisinopril 10mg", true),
          _buildScheduleItem("8:00 AM", "Vitamin D3 1000 IU", true),
          _buildScheduleItem("12:00 PM", "Metformin 500mg", false),
          _buildScheduleItem("8:00 PM", "Metformin 500mg", false),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(String time, String medication, bool taken) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 60,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color:
                  taken
                      ? Colors.green.withOpacity(0.2)
                      : Colors.orange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              time,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: taken ? Colors.green[700] : Colors.orange[700],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              medication,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                decoration: taken ? TextDecoration.lineThrough : null,
                color: taken ? Colors.grey : Colors.black,
              ),
            ),
          ),
          Icon(
            taken ? Icons.check_circle : Icons.radio_button_unchecked,
            color: taken ? Colors.green : Colors.grey,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Medications",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        if (medications.isEmpty)
          _buildEmptyState()
        else
          ...medications
              .map((medication) => _buildMedicationCard(medication))
              .toList(),
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
          Icon(Icons.medication_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            "No Medications",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Add your medications to track dosages and set reminders",
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationCard(Medication medication) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border:
            medication.isActive
                ? Border.all(color: Colors.blue[300]!, width: 2)
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
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.medication,
                  color: Colors.blue,
                  size: 24,
                ),
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
                            medication.name,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (medication.reminderEnabled)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.notifications_active,
                                  size: 12,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "REMINDER",
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    Text(
                      "${medication.dosage} • ${medication.frequency}",
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
                        onTap: () => _showEditMedicationDialog(medication),
                      ),
                      PopupMenuItem(
                        child: const Text("Delete"),
                        onTap: () => _deleteMedication(medication),
                      ),
                    ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMedicationDetail("Time", medication.timeOfDay),
              ),
              Expanded(
                child: _buildMedicationDetail(
                  "Prescribed by",
                  medication.prescribedBy,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildMedicationDetail(
                  "Start Date",
                  medication.startDate,
                ),
              ),
              Expanded(
                child: _buildMedicationDetail("End Date", medication.endDate),
              ),
            ],
          ),
          if (medication.notes.isNotEmpty) ...[
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
                      medication.notes,
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
          if (medication.sideEffects.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.warning_outlined,
                    color: Colors.orange,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Side Effects:",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.orange[700],
                          ),
                        ),
                        Text(
                          medication.sideEffects,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.orange[700],
                          ),
                        ),
                      ],
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
                medication.isActive ? Icons.circle : Icons.circle_outlined,
                color: medication.isActive ? Colors.green : Colors.grey,
                size: 12,
              ),
              const SizedBox(width: 4),
              Text(
                medication.isActive ? "Active" : "Inactive",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: medication.isActive ? Colors.green : Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildMedicationTips() {
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
              const Icon(
                Icons.lightbulb_outline,
                color: Colors.orange,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                "Medication Tips",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTipItem(
            "💊",
            "Take as prescribed",
            "Never skip doses or change dosage without consulting your doctor",
          ),
          _buildTipItem(
            "⏰",
            "Set reminders",
            "Use alarms or apps to remember medication times",
          ),
          _buildTipItem(
            "🍽️",
            "Food interactions",
            "Some medications should be taken with or without food",
          ),
          _buildTipItem(
            "📝",
            "Track side effects",
            "Keep a record of any side effects to discuss with your doctor",
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

  Widget _buildInteractionWarning() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning, color: Colors.red[600], size: 24),
              const SizedBox(width: 8),
              Text(
                "Drug Interaction Warning",
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
            "Always inform your healthcare providers about all medications you're taking, including over-the-counter drugs and supplements.",
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.red[600]),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.search, size: 16),
            label: const Text("Check Interactions"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
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

  void _showAddMedicationDialog() {
    _showMedicationDialog();
  }

  void _showEditMedicationDialog(Medication medication) {
    _showMedicationDialog(medication: medication);
  }

  void _showMedicationDialog({Medication? medication}) {
    final nameController = TextEditingController(text: medication?.name ?? '');
    final dosageController = TextEditingController(
      text: medication?.dosage ?? '',
    );
    final frequencyController = TextEditingController(
      text: medication?.frequency ?? '',
    );
    final timeController = TextEditingController(
      text: medication?.timeOfDay ?? '',
    );
    final prescribedByController = TextEditingController(
      text: medication?.prescribedBy ?? '',
    );
    final notesController = TextEditingController(
      text: medication?.notes ?? '',
    );
    final sideEffectsController = TextEditingController(
      text: medication?.sideEffects ?? '',
    );
    bool isActive = medication?.isActive ?? true;
    bool reminderEnabled = medication?.reminderEnabled ?? false;

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setState) => AlertDialog(
                  title: Text(
                    medication == null ? "Add Medication" : "Edit Medication",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: "Medication Name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: dosageController,
                                decoration: const InputDecoration(
                                  labelText: "Dosage",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: frequencyController,
                                decoration: const InputDecoration(
                                  labelText: "Frequency",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: timeController,
                          decoration: const InputDecoration(
                            labelText: "Time of Day",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: prescribedByController,
                          decoration: const InputDecoration(
                            labelText: "Prescribed By",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: notesController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: "Notes (Optional)",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: sideEffectsController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: "Side Effects (Optional)",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SwitchListTile(
                          title: const Text("Active Medication"),
                          value: isActive,
                          onChanged: (value) {
                            setState(() {
                              isActive = value;
                            });
                          },
                        ),
                        SwitchListTile(
                          title: const Text("Enable Reminders"),
                          value: reminderEnabled,
                          onChanged: (value) {
                            setState(() {
                              reminderEnabled = value;
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
                        if (nameController.text.isNotEmpty &&
                            dosageController.text.isNotEmpty) {
                          final newMedication = Medication(
                            name: nameController.text,
                            dosage: dosageController.text,
                            frequency: frequencyController.text,
                            timeOfDay: timeController.text,
                            prescribedBy: prescribedByController.text,
                            startDate: medication?.startDate ?? "Today",
                            endDate: medication?.endDate ?? "Ongoing",
                            isActive: isActive,
                            notes: notesController.text,
                            sideEffects: sideEffectsController.text,
                            reminderEnabled: reminderEnabled,
                          );

                          setState(() {
                            if (medication == null) {
                              medications.add(newMedication);
                            } else {
                              final index = medications.indexOf(medication);
                              medications[index] = newMedication;
                            }
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: Text(medication == null ? "Add" : "Save"),
                    ),
                  ],
                ),
          ),
    );
  }

  void _deleteMedication(Medication medication) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              "Delete Medication",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            content: Text(
              "Are you sure you want to delete ${medication.name}?",
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
                    medications.remove(medication);
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

class Medication {
  final String name;
  final String dosage;
  final String frequency;
  final String timeOfDay;
  final String prescribedBy;
  final String startDate;
  final String endDate;
  final bool isActive;
  final String notes;
  final String sideEffects;
  final bool reminderEnabled;

  Medication({
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.timeOfDay,
    required this.prescribedBy,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.notes,
    required this.sideEffects,
    required this.reminderEnabled,
  });
}
