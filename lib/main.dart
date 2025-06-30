
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:med_sync/features/application/provider/auth_service.dart';
import 'package:med_sync/features/application/provider/medicine_provider.dart';
import 'package:med_sync/features/domain/model/medicine_model.dart';
import 'package:med_sync/presentation/screens/auth/auth/login_screen.dart';
import 'package:med_sync/presentation/screens/auth/auth/otp_screen.dart';
import 'package:med_sync/presentation/screens/auth/welcome_screen.dart';
import 'package:med_sync/presentation/screens/home_page_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(MedicineAdapter());
  Hive.registerAdapter(MedicineTypeAdapter());
  await Hive.openBox<Medicine>('medicines');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => MedicineProvider()..loadMedicines()),
      ],
      child: MaterialApp(
        title: 'Med Sync',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          // User is logged in
          return FutureBuilder<bool>(
            future: authService.isEmailVerified(),
            builder: (context, emailSnapshot) {
              if (emailSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              if (emailSnapshot.hasData && emailSnapshot.data == true) {
                // Email is verified, go to HomeScreen
                return const HomeScreen();
              } else {
                // Email not verified, go to OtpScreen
                return const OtpScreen();
              }
            },
          );
        }
        // No user logged in, go to WelcomeScreen
        return const WelcomeScreen();
      },
    );
  }
}