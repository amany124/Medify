import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medify/core/di/di.dart';
import 'package:medify/core/theme/app_colors.dart';
import 'package:medify/core/utils/app_styles.dart';
import 'package:medify/features/medical_records/presentation/cubit/medical_records_cubit.dart';
import 'package:medify/features/medical_records/presentation/cubit/medical_records_state.dart';

import '../../../medical_records/data/models/medical_record.dart';

/// Widget for displaying medical records section
class MedicalRecordsSection extends StatelessWidget {
  const MedicalRecordsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            AppColors.secondaryColor.withValues(alpha: 0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border:
            Border.all(color: AppColors.secondaryColor.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryColor.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          const MedicalRecordsHeader(),
          const SizedBox(height: 20),

          // Records List
          BlocProvider(
            create: (context) =>
                getIt<MedicalRecordsCubit>()..getMedicalRecords(),
            child: const MedicalRecordsList(),
          ),
        ],
      ),
    );
  }
}

/// Header widget for medical records section
class MedicalRecordsHeader extends StatelessWidget {
  const MedicalRecordsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            AppColors.secondaryColor,
            AppColors.secondaryColor.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.medical_services,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Medical Records',
                  style: AppStyles.semiBold18.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Patient treatment history',
                  style: AppStyles.regular12.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          const RecordsCountBadge(),
        ],
      ),
    );
  }
}

/// Badge showing the count of medical records
class RecordsCountBadge extends StatelessWidget {
  const RecordsCountBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: BlocProvider(
        create: (context) => getIt<MedicalRecordsCubit>()..getMedicalRecords(),
        child: BlocBuilder<MedicalRecordsCubit, MedicalRecordsState>(
          builder: (context, state) {
            String recordsText = '0 Records';
            if (state is MedicalRecordsLoaded) {
              recordsText = '${state.records.data.length} Records';
            }
            return Text(
              recordsText,
              style: AppStyles.semiBold12.copyWith(color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}

/// List widget for displaying medical records
class MedicalRecordsList extends StatelessWidget {
  const MedicalRecordsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicalRecordsCubit, MedicalRecordsState>(
      builder: (context, state) {
        if (state is MedicalRecordsLoading) {
          return const MedicalRecordsLoadingWidget();
        } else if (state is MedicalRecordsLoaded) {
          final records = state.records.data;
          bool isDoctor = state.records.debug.isDoctor;
          if (records.isEmpty) {
            return const MedicalRecordsEmptyWidget();
          }
          return Column(
            children: records
                .map((record) =>
                    MedicalRecordCard(record: record, isDoctor: isDoctor))
                .toList(),
          );
        } else if (state is MedicalRecordsError) {
          return MedicalRecordsErrorWidget(message: state.message);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

/// Loading widget for medical records
class MedicalRecordsLoadingWidget extends StatelessWidget {
  const MedicalRecordsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text(
              'Loading medical records...',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

/// Empty state widget for medical records
class MedicalRecordsEmptyWidget extends StatelessWidget {
  const MedicalRecordsEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_open,
              size: 48,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 8),
            Text(
              'No medical records found',
              style: AppStyles.semiBold14.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            Text(
              'Create your first medical record',
              style: AppStyles.regular12.copyWith(
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Error widget for medical records
class MedicalRecordsErrorWidget extends StatelessWidget {
  final String message;

  const MedicalRecordsErrorWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.red.shade400,
            ),
            const SizedBox(height: 8),
            Text(
              'Error loading records',
              style: AppStyles.semiBold14.copyWith(
                color: Colors.red.shade700,
              ),
            ),
            Text(
              message,
              style: AppStyles.regular12.copyWith(
                color: Colors.red.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual medical record card
class MedicalRecordCard extends StatelessWidget {
  final MedicalRecord record;
  final bool isDoctor;
  const MedicalRecordCard(
      {super.key, required this.record, required this.isDoctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border:
            Border.all(color: AppColors.secondaryColor.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Card Header
          MedicalRecordCardHeader(record: record, isDoctor: isDoctor),
          // Card Content
          MedicalRecordCardContent(record: record),
        ],
      ),
    );
  }
}

/// Header for medical record card
class MedicalRecordCardHeader extends StatelessWidget {
  final MedicalRecord record;
  final bool isDoctor;

  const MedicalRecordCardHeader({
    super.key,
    required this.record,
    required this.isDoctor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor.withValues(alpha: 0.05),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isDoctor ? Icons.medical_services : Icons.person,
              color: AppColors.secondaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  !isDoctor
                        ? 'Dr. ${record.doctor?.name ?? 'Unknown Doctor'}'
                      : record.patient?.name ?? 'Unknown Patient',
                  style: AppStyles.semiBold14.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
                Text(
                  !isDoctor
                      ? 'Doctor ID: ${record.doctor?.id ?? "Unknown"}'
                      : 'Patient ID: ${record.patientId}',
                  style: AppStyles.regular10.copyWith(
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 2),
                if (!isDoctor && record.doctor?.specialization != null)
                  Text(
                    'Specialization: ${record.doctor?.specialization}',
                    style: AppStyles.regular10.copyWith(
                      color: Colors.teal.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                Text(
                  'Created: ${_formatMedicalRecordDate(record.date)}',
                  style: AppStyles.regular12.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color:
                  isDoctor ? Colors.teal.shade500 : _getTypeColor(record.type),
              borderRadius: BorderRadius.circular(20),
            ),
            child: isDoctor
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.verified,
                        color: Colors.white,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'DOCTOR',
                        style:
                            AppStyles.semiBold10.copyWith(color: Colors.white),
                      ),
                    ],
                  )
                : Text(
                    record.type.toUpperCase(),
                    style: AppStyles.semiBold10.copyWith(color: Colors.white),
                  ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'emergency':
        return Colors.red.shade600;
      case 'consultation':
        return Colors.blue.shade600;
      case 'checkup':
        return Colors.green.shade600;
      default:
        return AppColors.secondaryColor;
    }
  }

  String _formatMedicalRecordDate(DateTime? date) {
    if (date == null) return 'Unknown date';

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMM d, yyyy').format(date);
    }
  }
}

/// Content for medical record card
class MedicalRecordCardContent extends StatelessWidget {
  final MedicalRecord record;

  const MedicalRecordCardContent({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Diagnosis Section
          _buildDataRow(
            icon: Icons.medical_information,
            label: 'Diagnosis',
            value: record.diagnosis,
            color: Colors.red.shade600,
          ),

          const SizedBox(height: 12),

          // Treatment Section
          _buildDataRow(
            icon: Icons.healing,
            label: 'Treatment',
            value: record.treatment,
            color: Colors.green.shade600,
          ),

          // Symptoms Section
          if (record.symptoms.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildSymptomsSection(),
          ],

          // Notes Section
          if (record.notes.isNotEmpty && record.notes != 'No Notes !') ...[
            const SizedBox(height: 12),
            _buildDataRow(
              icon: Icons.note_alt,
              label: 'Notes',
              value: record.notes,
              color: Colors.blue.shade600,
            ),
          ],

          // Attachments Section
          if (record.attachments.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildAttachmentsSection(),
          ],
        ],
      ),
    );
  }

  Widget _buildDataRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppStyles.semiBold12.copyWith(color: color),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: AppStyles.regular12.copyWith(
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSymptomsSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            Icons.sick,
            size: 16,
            color: Colors.orange.shade600,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Symptoms',
                style: AppStyles.semiBold12.copyWith(
                  color: Colors.orange.shade600,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: record.symptoms.map<Widget>((symptom) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange.shade200),
                    ),
                    child: Text(
                      symptom,
                      style: AppStyles.regular10.copyWith(
                        color: Colors.orange.shade700,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAttachmentsSection() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.purple.shade100,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            Icons.attach_file,
            size: 16,
            color: Colors.purple.shade600,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Attachments (${record.attachments.length})',
          style: AppStyles.semiBold12.copyWith(
            color: Colors.purple.shade600,
          ),
        ),
      ],
    );
  }
}
