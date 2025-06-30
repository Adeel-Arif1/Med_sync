import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:med_sync/features/domain/model/medicine_model.dart';

class MedicineDebugScreen extends StatelessWidget {
  const MedicineDebugScreen({super.key});

  Future<void> clearBox() async {
    final box = Hive.box<Medicine>('medicines');
    print('Before clear: ${box.length}');
    await box.clear();
    print('After clear: ${box.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Medicine Box'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await clearBox();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Box cleared!')),
            );
          },
          child: const Text('Clear Medicine Box'),
        ),
      ),
    );
  }
}
