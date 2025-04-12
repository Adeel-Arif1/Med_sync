import 'package:flutter/material.dart';
import 'package:med_sync/presentation/screens/forgot_password.dart';
import 'package:med_sync/presentation/screens/verification_screen.dart';
import 'package:med_sync/presentation/screens/welcome_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VerificationScreen(),
    );
  }
}
