import 'package:flutter/material.dart';
import 'package:fitnestx/services/local_storage_service.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAlarmScreen extends StatefulWidget {
  const AddAlarmScreen({super.key});

  @override
  State<AddAlarmScreen> createState() => _AddAlarmScreenState();
}

class _AddAlarmScreenState extends State<AddAlarmScreen> {
  final _formKey = GlobalKey<FormState>();
  final _alarmNameController = TextEditingController();
  final _alarmTimeController = TextEditingController();
  // final LocalStorageService _storageService = LocalStorageService();

  @override
  void dispose() {
    _alarmNameController.dispose();
    _alarmTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Alarm",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save alarm to local storage
                    LocalStorageService.saveAlarmData([
                      ...LocalStorageService.getAlarmData(),
                      {
                        'name': _alarmNameController.text,
                        'time': _alarmTimeController.text,
                      },
                    ]);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Alarm saved successfully!')),
                    );
                    Navigator.pop(context);
                  }
                },
                icon: Icon(Icons.save, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alarm Name',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _alarmNameController,
                  decoration: InputDecoration(
                    hintText: 'Enter alarm name',
                    filled: true,
                    fillColor: Color(0XFFF8F8F8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an alarm name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Alarm Time',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _alarmTimeController,
                  decoration: InputDecoration(
                    hintText: 'Select time',
                    filled: true,
                    fillColor: Color(0XFFF8F8F8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.access_time, color: Colors.grey),
                      onPressed: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (picked != null) {
                          setState(() {
                            _alarmTimeController.text =
                                '${picked.hour}:${picked.minute}';
                          });
                        }
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an alarm time';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Save alarm to local storage
                        LocalStorageService.saveAlarmData([
                          ...LocalStorageService.getAlarmData(),
                          {
                            'name': _alarmNameController.text,
                            'time': _alarmTimeController.text,
                          },
                        ]);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Alarm saved successfully!')),
                        );
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF99B8FF),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Save Alarm',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
