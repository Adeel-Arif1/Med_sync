import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_sync/core/constants/app_colors.dart';
import 'package:med_sync/features/application/provider/medicine_provider.dart';
import 'package:med_sync/features/domain/model/medicine_model.dart';
import 'package:med_sync/presentation/screens/add_med_screen.dart';
import 'package:provider/provider.dart';

class MedicineInfoScreen extends StatelessWidget {
  final Medicine medicine;
  final DateTime selectedDate;

  const MedicineInfoScreen({
    super.key,
    required this.medicine,
    required this.selectedDate,
  });

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
              Provider.of<MedicineProvider>(context, listen: false).deleteMedicine(medicine);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to HomeScreen
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${medicine.name} Deleted")),
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
              Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  backgroundColor: const Color(0xFFF5F5F5),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
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
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.info, color: Colors.orange),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _showDeleteDialog(context),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
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
                    Text(
                      medicine.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Schedule
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          'Scheduled for ${medicine.time.format(context)}, ${DateFormat('EEEE').format(selectedDate)}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Dosage
                    Row(
                      children: [
                        const Icon(Icons.description_outlined, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          medicine.dosage,
                          style: const TextStyle(fontSize: 14),
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
                            final updatedMedicine = medicine.copyWith(
                              isTaken: !medicine.isTaken,
                            );
                            Provider.of<MedicineProvider>(context, listen: false).updateMedicine(updatedMedicine);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${medicine.name} marked as ${!medicine.isTaken ? 'taken' : 'not taken'}',
                                ),
                              ),
                            );
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 12,
                            ),
                          ),
                          child: Text(
                            medicine.isTaken ? 'Undo Taken' : 'Take',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () async {
                            final updatedMedicine = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddMedicinePage(
                                  selectedDate: selectedDate,
                                  existingMedicine: medicine,
                                ),
                              ),
                            );
                            if (updatedMedicine != null) {
                              Provider.of<MedicineProvider>(context, listen: false).updateMedicine(updatedMedicine);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${updatedMedicine.name} updated')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 12,
                            ),
                          ),
                          child: const Text(
                            'Edit',
                            style: TextStyle(color: Colors.white),
                          ),
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