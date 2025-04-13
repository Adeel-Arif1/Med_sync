import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'medicine_model.g.dart';

@HiveType(typeId: 0)
enum MedicineType {
  @HiveField(0)
  capsule,

  @HiveField(1)
  drops,

  @HiveField(2)
  tablet,
}

@HiveType(typeId: 1)
class Medicine extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String dosage;

  @HiveField(3)
  int hour;

  @HiveField(4)
  int minute;

  @HiveField(5)
  MedicineType type;

  @HiveField(6)
  bool isTaken;

  Medicine({
    required this.id,
    required this.name,
    required this.dosage,
    required this.hour,
    required this.minute,
    required this.type,
    this.isTaken = false,
  });

  /// Getter to reconstruct `TimeOfDay` from stored hour and minute.
  TimeOfDay get time => TimeOfDay(hour: hour, minute: minute);

  /// Optional convenience constructor
  factory Medicine.withTimeOfDay({
    required String id,
    required String name,
    required String dosage,
    required TimeOfDay time,
    required MedicineType type,
    bool isTaken = false,
  }) {
    return Medicine(
      id: id,
      name: name,
      dosage: dosage,
      hour: time.hour,
      minute: time.minute,
      type: type,
      isTaken: isTaken,
    );
  }
}
