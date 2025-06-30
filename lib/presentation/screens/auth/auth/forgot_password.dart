import 'package:flutter/material.dart';
import 'package:med_sync/presentation/screens/auth/auth/new_password_screen.dart';
import 'package:med_sync/presentation/widgets/auth_prompt.dart';
import 'package:med_sync/presentation/widgets/custom_appbar.dart';
import 'package:med_sync/presentation/widgets/custom_buttons.dart';
import 'package:med_sync/presentation/widgets/custom_text.dart';
import 'package:med_sync/presentation/widgets/custom_text_field.dart';
import 'package:med_sync/features/application/provider/auth_service.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetEmail() async {
    setState(() => _isLoading = true);
    final message = await _authService.sendPasswordResetEmail(_emailController.text);
    setState(() => _isLoading = false);
    if (message == 'Success') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const NewPasswordScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message ?? 'Failed to send reset email')),
      );
    }
  }

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
              const SizedBox(height: 40),
              PrimaryHeading('Forgot Password ?'),
              const SizedBox(height: 10),
              SecondaryHeading(
                'Dont worry! It occurs Please enter the email address linked with your account',
              ),
              const SizedBox(height: 30),
              CustomTextField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.email,
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : PrimaryButton(
                      text: 'Send Code',
                      onPressed: _sendResetEmail,
                    ),
              const Spacer(),
              AuthPrompt(),
            ],
          ),
        ),
      ),
    );
  }
}