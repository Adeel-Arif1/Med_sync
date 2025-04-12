import 'package:flutter/material.dart';
import 'package:med_sync/presentation/widgets/auth_prompt.dart';
import 'package:med_sync/presentation/widgets/custom_appbar.dart';
import 'package:med_sync/presentation/widgets/custom_buttons.dart';
import 'package:med_sync/presentation/widgets/custom_text.dart';
import 'package:med_sync/presentation/widgets/custom_text_field.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 40),

              PrimaryHeading('Verification  ?'),

              SizedBox(height: 10),

              SecondaryHeading(
                'Enter the verification code we just sent on your email address.',
              ),
              SizedBox(height: 30),

              PrimaryButton(text: 'Verify ', onPressed: () {}),
Spacer(),
                // Login Prompt
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Didn’t received code? '),
                  TextButton(
                    onPressed: () {
                      // Navigate to login page
                    },
                    child: const Text(
                      'Resend',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
