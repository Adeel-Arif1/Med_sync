
import 'package:flutter/material.dart';
import 'package:med_sync/features/application/provider/auth_service.dart';
import 'package:med_sync/presentation/screens/home_page_screen.dart';
import 'package:med_sync/presentation/widgets/custom_appbar.dart';
import 'package:med_sync/presentation/widgets/custom_buttons.dart';
import 'package:med_sync/presentation/widgets/custom_text.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PrimaryHeading('Verify Your Email'),
              const SizedBox(height: 20),
              const Text(
                'A verification email has been sent to your email address. Please check your inbox (and spam/junk folder) and click the verification link to continue.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : PrimaryButton(
                      text: 'I Have Verified My Email',
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        bool isVerified = await _authService.isEmailVerified();
                        if (isVerified) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const HomeScreen()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please verify your email first.'),
                            ),
                          );
                        }
                        setState(() {
                          _isLoading = false;
                        });
                      },
                    ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        setState(() {
                          _isLoading = true;
                        });
                        await _authService.getCurrentUser()?.sendEmailVerification();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Verification email resent.'),
                          ),
                        );
                        setState(() {
                          _isLoading = false;
                        });
                      },
                child: const Text(
                  'Resend Verification Email',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
