import 'package:flutter/material.dart';
import 'package:med_sync/features/domain/model/medicine_model.dart';

class MedicineProvider with ChangeNotifier {
  final List<Medicine> _medicines = [];

  List<Medicine> get medicines => _medicines;

  void addMedicine(Medicine medicine) {
    _medicines.add(medicine);
    notifyListeners();
  }

  void toggleTaken(String id) {
    final med = _medicines.firstWhere((m) => m.id == id);
    med.isTaken = !med.isTaken;
    notifyListeners();
  }

  void deleteMedicine(String id) {
    _medicines.removeWhere((m) => m.id == id);
    notifyListeners();
  }
}
