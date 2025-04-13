import 'package:flutter/material.dart';

enum MedicineType { capsule, drops, tablet }

class Medicine {
  final String id;
  final String name;
  final String dosage;
  final TimeOfDay time;
  final MedicineType type;
  bool isTaken;

  Medicine({
    required this.id,
    required this.name,
    required this.dosage,
    required this.time,
    required this.type,
    this.isTaken = false,
  });
}
