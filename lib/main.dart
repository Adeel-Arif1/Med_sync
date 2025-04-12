import 'package:flutter/material.dart';
import 'package:med_sync/presentation/screens/auth/forgot_password.dart';
import 'package:med_sync/presentation/screens/auth/new_password_screen.dart';
import 'package:med_sync/presentation/screens/auth/password_changed_screen.dart';
import 'package:med_sync/presentation/screens/auth/verification_screen.dart';
import 'package:med_sync/presentation/screens/auth/welcome_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PasswordChangedScreen(),
    );
  }
}
