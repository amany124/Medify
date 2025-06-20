import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medify/features/authentication/login/ui/cubits/cubit/login_cubit.dart';
import 'package:medify/features/authentication/login/ui/widgets/navigation_section.dart';
import 'package:medify/features/authentication/login/ui/widgets/switch__method_section.dart';
import 'package:medify/features/authentication/login/ui/widgets/user_login_section.dart';

import '../../../../../core/helpers/show_custom_snack_bar.dart';
import '../../../congradulations/views/congradulations.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          showCustomSnackBar('Welcome ${state.userModel.name}', context);
          print(state.userModel.name);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CongratulationsView(
                userName: state.userModel.name,
                isSignUp: false,
                isdoctor: state.userModel.role == 'doctor',
              ),
            ),
          );
        }
        if (state is LoginFailure) {
          showCustomSnackBar(state.failure.message, context, isError: true);
        }
      },
      child: const Padding(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(35),
            UserLoginSection(),
            Gap(18),
            SwitchMethodSection(),
            Gap(40),
            NavigationSection(),
          ],
        ),
      ),
    );
  }
}
