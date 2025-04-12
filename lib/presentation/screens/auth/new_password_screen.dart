import 'package:flutter/material.dart';
import 'package:med_sync/presentation/widgets/auth_prompt.dart';
import 'package:med_sync/presentation/widgets/custom_appbar.dart';
import 'package:med_sync/presentation/widgets/custom_buttons.dart';
import 'package:med_sync/presentation/widgets/custom_text.dart';
import 'package:med_sync/presentation/widgets/custom_text_field.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

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

              PrimaryHeading('Create New Password ?'),

              SizedBox(height: 10),

              SecondaryHeading(
                'Your new password must be unique from those previously used.',
              ),
              SizedBox(height: 30),

              const CustomTextField(label: 'New Password', icon: Icons.email),
              SizedBox(height: 30),
              CustomTextField(label: 'Confirm Password', icon: Icons.email),
              SizedBox(height: 30),

              PrimaryButton(text: 'Reset Password', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
