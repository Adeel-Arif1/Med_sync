import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:med_sync/features/domain/model/medicine_model.dart';

class MedicineProvider with ChangeNotifier {
  List<Medicine> _medicines = [];

  List<Medicine> get medicines => _medicines;

  // Load medicines from Hive
  Future<void> loadMedicines() async {
    var box = await Hive.openBox<Medicine>('medicines');
    _medicines = box.values.toList().cast<Medicine>();
    notifyListeners();
  }

  // Add medicine to the list and save to Hive
  Future<void> addMedicine(Medicine medicine) async {
    var box = await Hive.openBox<Medicine>('medicines');
    await box.add(medicine);
    _medicines.add(medicine);
    notifyListeners();
  }

  // Update medicine status in the list and in Hive
  Future<void> updateMedicineStatus(Medicine medicine) async {
    var box = await Hive.openBox<Medicine>('medicines');
    await medicine.save(); // Save changes to Hive
    notifyListeners();
  }

  // ✅ Delete medicine from Hive and list
  Future<void> deleteMedicine(Medicine medicine) async {
    var box = await Hive.openBox<Medicine>('medicines');

    // First find the key for this medicine
    final key = box.keys.firstWhere(
      (k) => box.get(k) == medicine,
      orElse: () => null,
    );

    if (key != null) {
      await box.delete(key);
      _medicines.remove(medicine);
      notifyListeners();
    }
  }
}
