// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/helpers/cache_manager.dart';
import 'package:medify/core/utils/keys.dart';
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
      listener: (context, state) async {
        if (state is LoginSuccess) {
          await CacheManager.setData(
            key: Keys.isLoggedIn,
            value: true,
          );

          showCustomSnackBar(
              'Welcome ${state.responseUserModel.name}', context);
          print(state.responseUserModel.name);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CongratulationsView(
                userName: state.responseUserModel.name,
                isSignUp: false,
                isdoctor: state.responseUserModel.role == 'doctor',
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
