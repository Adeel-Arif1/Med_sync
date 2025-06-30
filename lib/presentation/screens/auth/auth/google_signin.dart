import 'package:flutter/material.dart';
import 'package:med_sync/core/constants/app_colors.dart';
import 'package:med_sync/presentation/screens/home_page_screen.dart';
import 'package:med_sync/presentation/widgets/custom_appbar.dart';
import 'package:med_sync/presentation/widgets/custom_buttons.dart';
import 'package:med_sync/features/application/provider/auth_service.dart';

class GoogleSignin extends StatefulWidget {
  const GoogleSignin({super.key});

  @override
  _GoogleSigninState createState() => _GoogleSigninState();
}

class _GoogleSigninState extends State<GoogleSignin> {
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
            children: [
              const Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SecondaryButton(
                      text: 'Google Sign-In',
                      onPressed: () async {
                        setState(() => _isLoading = true);
                        final message = await _authService.signInWithGoogle();
                        setState(() => _isLoading = false);
                        if (message == 'Success') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const HomeScreen()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(message ?? 'Google Sign-In failed')),
                          );
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}