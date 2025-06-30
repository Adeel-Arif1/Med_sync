import 'package:flutter/material.dart';
import 'package:med_sync/presentation/screens/auth/auth/login_screen.dart';
import 'package:med_sync/presentation/widgets/custom_buttons.dart';
import 'package:med_sync/presentation/widgets/custom_text.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 150),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/done.png',
                      width: 150,
                      height: 150,
                    ),
                    Image.asset(
                      'assets/images/tick.png',
                      width: 80,
                      height: 80,
                    ),
                  ],
                ),
              ),
              PrimaryHeading('Password Changed!'),
              const SizedBox(height: 10),
              SecondaryHeading('Your password has been changed successfully.'),
              const SizedBox(height: 50),
              PrimaryButton(
                text: 'Back to Login',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}