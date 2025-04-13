import 'package:flutter/material.dart';
import 'package:med_sync/features/application/provider/medicine_provider.dart';
import 'package:med_sync/presentation/screens/add_med_screen.dart';
import 'package:med_sync/presentation/screens/auth/auth/forgot_password.dart';
import 'package:med_sync/presentation/screens/auth/auth/new_password_screen.dart';
import 'package:med_sync/presentation/screens/auth/auth/password_changed_screen.dart';
import 'package:med_sync/presentation/screens/auth/auth/verification_screen.dart';
import 'package:med_sync/presentation/screens/auth/manage_med_screen.dart';
import 'package:med_sync/presentation/screens/auth/welcome_screen.dart';
import 'package:med_sync/presentation/screens/home_page_screen.dart';
import 'package:med_sync/presentation/screens/medinfo_screen.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(const MainApp());
// }

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MedicineProvider()),
      ],
      child: const MainApp(),
    ),
  );
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( create: (_) => MedicineProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(
      
      
        ),
      ),
    );
  }
}
