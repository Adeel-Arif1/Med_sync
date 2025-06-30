import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:med_sync/features/domain/model/medicine_model.dart';

class DatabaseService {
  static const String _boxName = 'medicines';

  static Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(MedicineTypeAdapter()); // If you use MedicineType
    }

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(MedicineAdapter());
    }

    await Hive.openBox<Medicine>(_boxName);
  }




  static Box<Medicine> get _box => Hive.box<Medicine>(_boxName);

  static Future<Medicine> addMedicine(Medicine medicine) async {
    await _box.put(medicine.id, medicine);
    return medicine;
  }
//
  static Future<void> updateMedicine(Medicine medicine) async {
    await _box.put(medicine.id, medicine); // Consistent with String id
  }

 static Future<void> deleteMedicine(String id) async {
  if (_box.containsKey(id)) {
    await _box.delete(id);
    debugPrint("Deleted medicine with ID: $id");
  } else {
    debugPrint("Delete failed: ID $id not found.");
  }
}

  static Future<List<Medicine>> getAllMedicines() async {
    return _box.values.toList();
  }
}
