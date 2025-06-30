
import 'package:flutter/material.dart';
import 'package:med_sync/features/application/provider/auth_service.dart';
import 'package:med_sync/features/application/provider/medicine_provider.dart';
import 'package:med_sync/features/domain/model/medicine_model.dart';
import 'package:med_sync/presentation/screens/add_med_screen.dart';
import 'package:med_sync/presentation/screens/auth/welcome_screen.dart';
import 'package:med_sync/presentation/screens/home_page_screen.dart';

import 'package:med_sync/presentation/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:med_sync/core/constants/app_colors.dart';

class ManageMedScreen extends StatelessWidget {
  const ManageMedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                SizedBox(height: 120),
                Image.asset(
                  'assets/images/reminder.png',
                  height: 200,
                  width: 200,
                ),
                SizedBox(height: 30),
                PrimaryHeading('Manage your meds'),
                SizedBox(height: 30),
                SecondaryHeading(
                  'Add your meds to be reminded on time and track your health ',
                ),
                SizedBox(height: 150),
                SizedBox(
                  height: 60,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () async {
                      final newMedicine = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddMedicinePage(
                            selectedDate: DateTime.now(),
                          ),
                        ),
                      );
                      if (newMedicine != null) {
                        final provider = Provider.of<MedicineProvider>(context, listen: false);
                        provider.addMedicine(newMedicine);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Medicine added successfully!')),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFBBC05),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                    ),
                    child: const Text(
                      'Add Medicine',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () async {
                    final authService = AuthService();
                    await authService.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                    );
                  },
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      color: AppColors.red ?? Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
