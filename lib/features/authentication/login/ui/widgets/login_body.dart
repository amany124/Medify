<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/helpers/cache_manager.dart';
import 'package:medify/core/utils/keys.dart';
<<<<<<< HEAD
=======
=======
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
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
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
      listener: (context, state) async {
        if (state is LoginSuccess) {
          await CacheManager.setData(
            key: Keys.isLoggedIn,
            value: true,
          );

<<<<<<< HEAD
          showCustomSnackBar(
              'Welcome ${state.responseUserModel.name}', context);
          print(state.responseUserModel.name);
          //cache the user data
          await CacheManager.setData(
            key: Keys.role,
            value: state.responseUserModel.role,
          );
=======
=======
      listener: (context, state) {
        if (state is LoginSuccess) {
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
          showCustomSnackBar(
              'Welcome ${state.responseUserModel.name}', context);
          print(state.responseUserModel.name);
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
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
