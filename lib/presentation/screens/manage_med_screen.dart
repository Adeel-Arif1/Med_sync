import 'package:flutter/material.dart';
import 'package:med_sync/presentation/widgets/custom_text.dart';

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

                SizedBox(height: 60,
                width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      // Your action here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFBBC05), // 🌟 Fill color
                      foregroundColor: Colors.white, // 🌟 Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // 🌟 Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ), // Optional: size
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
