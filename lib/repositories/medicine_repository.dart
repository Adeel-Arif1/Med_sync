// class MedicineRepository {
//   final Box _box = DatabaseService.medicinesBox;

//   List<Medicine> getMedicines() {
//     return _box.values.cast<Medicine>().toList();
//   }

//   Future<void> addMedicine(Medicine medicine) async {
//     await _box.put(medicine.id, medicine);
//   }

//   Future<void> updateMedicine(Medicine medicine) async {
//     await _box.put(medicine.id, medicine);
//   }

//   Future<void> deleteMedicine(String id) async {
//     await _box.delete(id);
//   }
// }