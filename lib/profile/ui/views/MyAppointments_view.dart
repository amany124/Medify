import 'package:flutter/material.dart';
import '../widgets/appointments_view_body.dart';

class AppointmentsView extends StatelessWidget {
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppointmentsViewBody(),
    );
  }
}
