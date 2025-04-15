import 'package:flutter/material.dart';
import 'package:med_sync/core/database_service.dart';

import 'package:med_sync/features/domain/model/medicine_model.dart';

class MedicineProvider with ChangeNotifier {
  List<Medicine> _medicines = [];

  List<Medicine> get medicines => _medicines;

  // Load medicines from Hive
  Future<void> loadMedicines() async {
    _medicines = await DatabaseService.getAllMedicines();
    notifyListeners();
  }

  // Add medicine to the list and save to Hive
  Future<void> addMedicine(Medicine medicine) async {
    final newMedicine = await DatabaseService.addMedicine(medicine);
    _medicines.add(newMedicine);
    notifyListeners();
  }

  // Update medicine in the list and in Hive
  Future<void> updateMedicine(Medicine medicine) async {
    await DatabaseService.updateMedicine(medicine);
    final index = _medicines.indexWhere((m) => m.id == medicine.id);
    if (index != -1) {
      _medicines[index] = medicine;
      notifyListeners();
    }
  }

  // Update medicine status
  Future<void> updateMedicineStatus(Medicine medicine) async {
    await updateMedicine(medicine); // Reuse the update method
  }

  // Delete medicine from Hive and list
  Future<void> deleteMedicine(Medicine medicine) async {
    if (medicine.id != null) {
      await DatabaseService.deleteMedicine(medicine.id!);
      _medicines.removeWhere((m) => m.id == medicine.id);
      notifyListeners();
    }
  }
}