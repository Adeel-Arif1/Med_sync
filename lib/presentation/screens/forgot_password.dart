import 'package:flutter/material.dart';
import 'package:med_sync/presentation/widgets/auth_prompt.dart';
import 'package:med_sync/presentation/widgets/custom_appbar.dart';
import 'package:med_sync/presentation/widgets/custom_buttons.dart';
import 'package:med_sync/presentation/widgets/custom_text.dart';
import 'package:med_sync/presentation/widgets/custom_text_field.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

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

              PrimaryHeading('Forgot Password ?'),

              SizedBox(height: 10),

              SecondaryHeading(
                'Dont worry! It occurs Please enter the email address linked with your account',
              ),
              SizedBox(height: 30),

              const CustomTextField(label: 'Email', icon: Icons.email),
              SizedBox(height: 30),

              PrimaryButton(text: 'Send Code', onPressed: () {}),
Spacer(),
              AuthPrompt(),
            ],
          ),
        ),
      ),
    );
  }
}
