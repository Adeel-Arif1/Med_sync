import 'package:hive_flutter/hive_flutter.dart';
import 'package:med_sync/features/domain/model/medicine_model.dart';

class DatabaseService {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MedicineAdapter()); // Register your medicine adapter
    await Hive.openBox('medicines');
  }

  static Box get medicinesBox => Hive.box('medicines');

  // Add a new medicine
  static Future<void> addMedicine(Medicine medicine) async {
    await medicinesBox.add(medicine);
  }

  // Retrieve all medicines
  static List<Medicine> getAllMedicines() {
    return medicinesBox.values.toList().cast<Medicine>();
  }

  // Update a medicine (e.g., mark as taken)
  static Future<void> updateMedicine(Medicine medicine) async {
    int index = medicinesBox.values.toList().indexOf(medicine);
    await medicinesBox.putAt(index, medicine);
  }
}
