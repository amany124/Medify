import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../widgets/password_field.dart';
//import '../widgets/password_field.dart';

class PasswordManager extends StatelessWidget {
  const PasswordManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,color: Colors.blue,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Password Manager',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 90),
        child: Column(
          children: [
            const PasswordField(labelText: 'Current Password'),
            const Gap(30),
            //const SizedBox(height: 16),
            const PasswordField(labelText: 'New Password'),
            const Gap(30),
            //const SizedBox(height: 16),
            const PasswordField(labelText: 'Confirm New Password'),
            const Gap(60),
            //const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Change Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}