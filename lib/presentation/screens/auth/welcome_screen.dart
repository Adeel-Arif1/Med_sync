import 'package:flutter/material.dart';
import 'package:med_sync/core/constants/app_colors.dart';
import 'package:med_sync/presentation/screens/auth/auth/login_screen.dart';
import 'package:med_sync/presentation/widgets/custom_buttons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/pills.png', // make sure you add this image
                  height: 200,
                ),
                const SizedBox(height: 40),
                const Text(
                  'Welcome To',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFFFF7551),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'MediMinder',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Your personal assistant for managing\nyour medication schedule.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 40),

                //  // Login Button
                PrimaryButton(
                  text: 'Login',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                    // Add login logic
                  },
                ),

                const SizedBox(height: 12),
                SecondaryButton(text: 'Register', onPressed: () {
                  // Add login logic
                },),

                 // Login Prompt
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      // Navigate to login page
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
