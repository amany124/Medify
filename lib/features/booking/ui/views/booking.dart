import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/routing/extensions.dart';
import 'package:medify/core/services/api_service.dart';
import 'package:medify/features/booking/data/repos/appointment_repo.dart';
import 'package:medify/features/booking/presentation/cubit/appointment_state.dart';
import 'package:medify/features/booking/presentation/cubit/patient_appointment_cubit.dart';

import '../../../../core/helpers/show_custom_snack_bar.dart';
import '../widgets/doctor_info.dart';
import '../widgets/time_selection.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientAppointmentCubit(
        appointmentRepo: AppointmentRepoImpl(apiServices: ApiServices(Dio())),
      ),
      child: BlocConsumer<PatientAppointmentCubit, AppointmentState>(
        listener: (context, state) {
          if (state is AppointmentErrorState) {
            showCustomSnackBar(state.errorMessage, context, isError: true);
          }
          if (state is AppointmentCreatedSuccessState) {
            showCustomSnackBar('Appointment scheduled successfully', context,
                isError: false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.blue,
              elevation: 0,
              leading: InkWell(
                onTap: () => context.pop(),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            body: const Column(
              children: [
                DoctorInfoSection(),
                Expanded(child: TimeSelectionSection()),
              ],
            ),
          );
        },
      ),
    );
  }
}
