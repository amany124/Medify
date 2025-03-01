import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/routing/extensions.dart';
import 'package:medify/features/authentication/register/ui/cubit/register_cubit/register_cubit.dart';

import '../../../login/ui/widgets/navigate_gredient_button.dart';
import '../../../login/ui/widgets/navigate_reverse_arrow.dart';

class RegisterNavigationSection extends StatelessWidget {
  const RegisterNavigationSection({
    super.key,
    this.isdoctor = false,
    this.onpressed,
  });
  final bool? isdoctor;
  final void Function()? onpressed;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                ReverseArrow(
                  onPressed: () {
                    context.pop();
                  },
                ),
                const Gap(30),
                GradientButton(
                  isloading: state is RegisterLoading,
                  label: 'sign up',
                  onpressed: onpressed,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
