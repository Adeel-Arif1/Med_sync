import 'package:flutter/material.dart';

class MedicineReminderScreen extends StatelessWidget {
  const MedicineReminderScreen({super.key});

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you really want to delete this medicine?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); 
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // ✅ Add delete logic here
              Navigator.pop(context); // Close dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Medicine Deleted")),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  backgroundColor: Color(0xFFF5F5F5),
                  child: Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F4FF),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    // Top Row Icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.info, color: Colors.orange),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Did you take your Medicine?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Medicine Image
                    Image.asset(
                      'assets/images/pill.png',
                      width: 60,
                      height: 60,
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Vitamin D',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Schedule
                    Row(
                      children: const [
                        Icon(Icons.calendar_today, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          'Scheduled for 09:41 PM, Wednesday',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Dosage
                    Row(
                      children: const [
                        Icon(Icons.description_outlined, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          '1 Capsule, 10000mg',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Take logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                          ),
                          child: const Text('Take', style: TextStyle(color: Colors.white),),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () => _showDeleteDialog(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                           // foregroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                          ),
                          child: const Text('Edit',style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
