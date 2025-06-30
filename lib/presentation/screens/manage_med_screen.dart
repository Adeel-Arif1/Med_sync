import 'package:flutter/material.dart';
import 'package:med_sync/features/application/provider/medicine_provider.dart';
import 'package:med_sync/features/domain/model/medicine_model.dart';
import 'package:med_sync/presentation/screens/add_med_screen.dart';
import 'package:med_sync/presentation/screens/home_page_screen.dart';
import 'package:med_sync/presentation/widgets/custom_text.dart';
import 'package:provider/provider.dart';

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
                SizedBox(height: 190),
                SizedBox(
                  height: 60,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () async {
                      final newMedicine = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AddMedicinePage(
                            selectedDate: DateTime.now(), // Pass current date
                          ),
                        ),
                      );
                      if (newMedicine != null) {
                        final provider = Provider.of<MedicineProvider>(context, listen: false);
                        provider.addMedicine(newMedicine);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Medicine added successfully!')),
                        );
                        // Optionally navigate to HomeScreen
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}