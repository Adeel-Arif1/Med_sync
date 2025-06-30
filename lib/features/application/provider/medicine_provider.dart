import 'package:flutter/material.dart';
import 'package:med_sync/core/database_service.dart';
import 'package:med_sync/features/domain/model/medicine_model.dart';

class MedicineProvider with ChangeNotifier {
  List<Medicine> _medicines = [];
  List<Medicine> get medicines => _medicines;

  Future<void> loadMedicines() async {
    try {
      _medicines = await DatabaseService.getAllMedicines();
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading medicines: $e");
      _medicines = [];
      notifyListeners();
    }
  }

  Future<void> addMedicine(Medicine medicine) async {
    try {
      final addedMedicine = await DatabaseService.addMedicine(medicine);
      _medicines.add(addedMedicine);
      notifyListeners();
    } catch (e) {
      debugPrint("Error adding medicine: $e");
    }
  }
//
  Future<void> updateMedicine(Medicine medicine) async {
    try {
      debugPrint("Updating medicine with ID: ${medicine.id}");
      await DatabaseService.updateMedicine(medicine);
      final index = _medicines.indexWhere((m) => m.id == medicine.id);
      if (index != -1) {
        _medicines[index] = medicine;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error updating medicine: $e");
    }
  }

  Future<void> deleteMedicine(Medicine medicine) async {
    try {
      debugPrint("Deleting medicine with ID: ${medicine.id}");
      await DatabaseService.deleteMedicine(medicine.id);
      _medicines.removeWhere((m) => m.id == medicine.id);
      notifyListeners();
    } catch (e) {
      debugPrint("Error deleting medicine: $e");
    }
  }

  Future<void> updateMedicineStatus(Medicine medicine) async {
    try {
      final updatedMedicine = medicine.copyWith(isTaken: !medicine.isTaken);
      await DatabaseService.updateMedicine(updatedMedicine);
      final index = _medicines.indexWhere((m) => m.id == medicine.id);
      if (index != -1) {
        _medicines[index] = updatedMedicine;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error updating medicine status: $e");
    }
  }
}
