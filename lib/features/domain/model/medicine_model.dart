import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'medicine_model.g.dart'; // This is critical for code generation
//part 'medicine_model.g.dart';

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
class Medicine {
  @HiveField(0)
  final String id;
  //final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String dosage;

  @HiveField(3)
  final int hour;

  @HiveField(4)
  final int minute;

  @HiveField(5)
  final MedicineType type;

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

  TimeOfDay get time => TimeOfDay(hour: hour, minute: minute);

  factory Medicine.withTimeOfDay({
    String? id,
    required String name,
    required String dosage,
    required TimeOfDay time,
    required MedicineType type,
    bool isTaken = false, //medicine.isTaken = true;
  }) {
    return Medicine(
      id: id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      dosage: dosage,
      hour: time.hour,
      minute: time.minute,
      type: type,
      isTaken: isTaken,
    );
  }

  Medicine copyWith({
    String? id,
    String? name,
    String? dosage,
    int? hour,
    int? minute,
    MedicineType? type,
    bool? isTaken,
  }) {
    return Medicine(
      id: id ?? this.id,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      type: type ?? this.type,

      isTaken: isTaken ?? this.isTaken,
    );
  }
}
