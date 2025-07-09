import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/helpers/show_custom_snack_bar.dart';
import 'package:medify/features/booking/data/models/scheduled_appointment.dart';
import 'package:medify/features/medical_records/data/models/medical_record.dart';
import 'package:medify/features/medical_records/presentation/cubit/medical_records_cubit.dart';

import '../../presentation/cubit/medical_records_state.dart';

class CreateMedicalRecordPage extends StatefulWidget {
  final ScheduledAppointment appointment;

  const CreateMedicalRecordPage({
    super.key,
    required this.appointment,
  });

  @override
  State<CreateMedicalRecordPage> createState() =>
      _CreateMedicalRecordPageState();
}

class _CreateMedicalRecordPageState extends State<CreateMedicalRecordPage> {
  final _formKey = GlobalKey<FormState>();
  final _diagnosisController = TextEditingController();
  final _treatmentController = TextEditingController();
  final _notesController = TextEditingController();

  String _selectedType = 'consultation';
  final List<String> _symptoms = [];
  final TextEditingController _symptomController = TextEditingController();

  final List<String> _popularSymptoms = [
    'Headache',
    'Fever',
    'Cough',
    'Fatigue',
    'Nausea',
    'Chest pain',
    'Shortness of breath',
    'Dizziness',
    'Abdominal pain',
    'Back pain',
  ];

  final List<String> _recordTypes = [
    'consultation',
    'checkup',
    'follow-up',
    'emergency',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFF),
        elevation: 0,
        title: const Text(
          'Create Medical Record',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff1B5A8C),
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
          color: const Color(0xff1B5A8C),
        ),
      ),
      body: BlocListener<MedicalRecordsCubit, MedicalRecordsState>(
        listener: (context, state) {
          log('CreateMedicalRecordPage: State changed to ${state.runtimeType}');
          if (state is MedicalRecordCreated) {
            log('CreateMedicalRecordPage: Medical record created successfully');
            showCustomSnackBar('Medical record created successfully', context);
            Navigator.pop(context, true); // Return true to indicate success
          } else if (state is MedicalRecordsError) {
            log('CreateMedicalRecordPage: Error occurred: ${state.message}');
            showCustomSnackBar(state.message, context, isError: true);
          } else if (state is MedicalRecordsLoading) {
            log('CreateMedicalRecordPage: Loading state');
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Patient Info Card
                _buildPatientInfoCard(),
                const Gap(20),

                // Diagnosis
                _buildSectionTitle('Diagnosis'),
                const Gap(10),
                _buildTextField(
                  controller: _diagnosisController,
                  hintText: 'Enter diagnosis',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter diagnosis';
                    }
                    return null;
                  },
                ),
                const Gap(20),

                // Symptoms
                _buildSectionTitle('Symptoms'),
                const Gap(10),
                _buildSymptomsSection(),
                const Gap(20),

                // Type
                _buildSectionTitle('Type'),
                const Gap(10),
                _buildTypeDropdown(),
                const Gap(20),

                // Treatment
                _buildSectionTitle('Treatment'),
                const Gap(10),
                _buildTextField(
                  controller: _treatmentController,
                  hintText: 'Enter treatment plan',
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter treatment plan';
                    }
                    return null;
                  },
                ),
                const Gap(20),

                // Notes
                _buildSectionTitle('Additional Notes'),
                const Gap(10),
                _buildTextField(
                  controller: _notesController,
                  hintText: 'Enter additional notes (optional)',
                  maxLines: 3,
                ),
                const Gap(30),

                // Create Button
                _buildCreateButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPatientInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8F1FF)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xff2260FF).withOpacity(0.1),
            child: Text(
              widget.appointment.patient.name[0].toUpperCase(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff2260FF),
              ),
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.appointment.patient.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1B5A8C),
                  ),
                ),
                const Gap(4),
                Text(
                  'Appointment: ${widget.appointment.reason}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF7F8C8D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xff1B5A8C),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE8F1FF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE8F1FF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xff2260FF), width: 2),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildSymptomsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Add symptom field
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _symptomController,
                decoration: InputDecoration(
                  hintText: 'Add symptom',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE8F1FF)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFE8F1FF)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Color(0xff2260FF), width: 2),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
                onFieldSubmitted: _addSymptom,
              ),
            ),
            const Gap(10),
            ElevatedButton(
              onPressed: () => _addSymptom(_symptomController.text),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2260FF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
              ),
              child: const Icon(Icons.add),
            ),
          ],
        ),
        const Gap(10),

        // Popular symptoms
        const Text(
          'Popular symptoms:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF7F8C8D),
          ),
        ),
        const Gap(8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _popularSymptoms.map((symptom) {
            return GestureDetector(
              onTap: () => _addSymptom(symptom),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xff2260FF).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: const Color(0xff2260FF).withOpacity(0.3)),
                ),
                child: Text(
                  symptom,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xff2260FF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        // Selected symptoms
        if (_symptoms.isNotEmpty) ...[
          const Gap(15),
          const Text(
            'Selected symptoms:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff1B5A8C),
            ),
          ),
          const Gap(8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _symptoms.map((symptom) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xff27AE60).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: const Color(0xff27AE60).withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      symptom,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff27AE60),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Gap(4),
                    GestureDetector(
                      onTap: () => _removeSymptom(symptom),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Color(0xff27AE60),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  Widget _buildTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE8F1FF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE8F1FF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xff2260FF), width: 2),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
      items: _recordTypes.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(type.capitalize()),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedType = value!;
        });
      },
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    return BlocBuilder<MedicalRecordsCubit, MedicalRecordsState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: state is MedicalRecordsLoading
                ? null
                : () {
                    _createMedicalRecord(context);
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff2260FF),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: state is MedicalRecordsLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : const Text(
                    'Create Medical Record',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        );
      },
    );
  }

  void _addSymptom(String symptom) {
    if (symptom.trim().isNotEmpty && !_symptoms.contains(symptom.trim())) {
      setState(() {
        _symptoms.add(symptom.trim());
        _symptomController.clear();
      });
    }
  }

  void _removeSymptom(String symptom) {
    setState(() {
      _symptoms.remove(symptom);
    });
  }

  void _createMedicalRecord(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final medicalRecord = MedicalRecord(
        patientId: widget.appointment.patient.id,
        diagnosis: _diagnosisController.text,
        symptoms: _symptoms,
        type: _selectedType,
        treatment: _treatmentController.text,
        notes: _notesController.text.isEmpty
            ? 'No Notes !'
            : _notesController.text,
        attachments: [],
      );
      log('create medical record');
      log('Medical record data: ${medicalRecord.toJson()}');

      try {
        final cubit = context.read<MedicalRecordsCubit>();
        log('Successfully got cubit instance: $cubit');
        cubit.createMedicalRecord(medicalRecord: medicalRecord);
      } catch (e) {
        log('Error getting cubit: $e');
      }
    }
  }

  @override
  void dispose() {
    _diagnosisController.dispose();
    _treatmentController.dispose();
    _notesController.dispose();
    _symptomController.dispose();
    super.dispose();
  }
}

extension StringCapitalization on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
