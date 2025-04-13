// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicineAdapter extends TypeAdapter<Medicine> {
  @override
  final int typeId = 1;

  @override
  Medicine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Medicine(
      id: fields[0] as String,
      name: fields[1] as String,
      dosage: fields[2] as String,
      hour: fields[3] as int,
      minute: fields[4] as int,
      type: fields[5] as MedicineType,
      isTaken: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Medicine obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.dosage)
      ..writeByte(3)
      ..write(obj.hour)
      ..writeByte(4)
      ..write(obj.minute)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.isTaken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MedicineTypeAdapter extends TypeAdapter<MedicineType> {
  @override
  final int typeId = 0;

  @override
  MedicineType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MedicineType.capsule;
      case 1:
        return MedicineType.drops;
      case 2:
        return MedicineType.tablet;
      default:
        return MedicineType.capsule;
    }
  }

  @override
  void write(BinaryWriter writer, MedicineType obj) {
    switch (obj) {
      case MedicineType.capsule:
        writer.writeByte(0);
        break;
      case MedicineType.drops:
        writer.writeByte(1);
        break;
      case MedicineType.tablet:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicineTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
