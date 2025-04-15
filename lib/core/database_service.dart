import 'package:hive_flutter/hive_flutter.dart';
import 'package:med_sync/features/domain/model/medicine_model.dart';

class DatabaseService {
  static const String _boxName = 'medicines';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MedicineAdapter());
    await Hive.openBox<Medicine>(_boxName);
  }

  static Box<Medicine> get _box => Hive.box<Medicine>(_boxName);

  // Add a new medicine and return it with generated key as ID
  static Future<Medicine> addMedicine(Medicine medicine) async {
    final key = await _box.add(medicine);
    return medicine.copyWith(id: key.toString());
  }

  // Retrieve all medicines
  static List<Medicine> getAllMedicines() {
    return _box.values.toList();
  }

  // Update a medicine
  static Future<void> updateMedicine(Medicine medicine) async {
    if (medicine.id == null) return;
    final key = int.tryParse(medicine.id!);
    if (key != null) {
      await _box.put(key, medicine);
    }
  }

  // Delete a medicine
  static Future<void> deleteMedicine(String id) async {
    final key = int.tryParse(id);
    if (key != null) {
      await _box.delete(key);
    }
  }
}