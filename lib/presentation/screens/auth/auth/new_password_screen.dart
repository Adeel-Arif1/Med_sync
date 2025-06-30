import 'package:flutter/material.dart';
import 'package:med_sync/presentation/screens/auth/auth/password_changed_screen.dart';
import 'package:med_sync/presentation/widgets/auth_prompt.dart';
import 'package:med_sync/presentation/widgets/custom_appbar.dart';
import 'package:med_sync/presentation/widgets/custom_buttons.dart';
import 'package:med_sync/presentation/widgets/custom_text.dart';
import 'package:med_sync/presentation/widgets/custom_text_field.dart';
import 'package:med_sync/features/application/provider/auth_service.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() async {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }
    setState(() => _isLoading = true);
    final message = await _authService.resetPassword(_newPasswordController.text);
    setState(() => _isLoading = false);
    if (message == 'Success') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PasswordChangedScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message ?? 'Failed to reset password')),
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
              PrimaryHeading('Create New Password ?'),
              const SizedBox(height: 10),
              SecondaryHeading(
                'Your new password must be unique from those previously used.',
              ),
              const SizedBox(height: 30),
              CustomTextField(
                controller: _newPasswordController,
                label: 'New Password',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 30),
              CustomTextField(
                controller: _confirmPasswordController,
                label: 'Confirm Password',
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : PrimaryButton(
                      text: 'Reset Password',
                      onPressed: _resetPassword,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}