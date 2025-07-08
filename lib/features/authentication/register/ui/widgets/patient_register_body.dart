import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medify/features/authentication/register/ui/widgets/patient_registration_section.dart';
import '../../../../../core/helpers/show_custom_snack_bar.dart';
import '../../../congradulations/views/congradulations.dart';
import '../cubit/register_cubit/register_cubit.dart';

class PatientRigesterBody extends StatelessWidget {
  const PatientRigesterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          showCustomSnackBar('Registration Successful', context);
          print(state.registerUserModel.name);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CongratulationsView(
                userName: state.registerUserModel.name,
                isdoctor: false,
              ),
            ),
          );
        }
        if (state is RegisterFailure) {
          showCustomSnackBar(state.failure.message, context, isError: true);
        }
      },
      child: const Padding(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(15),
            PatientRegistrationSection(),
            Gap(20),
          ],
        ),
      ),
    );
  }
}
