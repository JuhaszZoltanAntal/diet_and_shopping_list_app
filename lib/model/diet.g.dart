// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DietAdapter extends TypeAdapter<Diet> {
  @override
  final int typeId = 2;

  @override
  Diet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Diet(
      fields[0] as String,
      fields[1] as int,
      fields[2] as int,
      (fields[3] as List).cast<Meal>(),
      (fields[4] as List).cast<Meal>(),
      (fields[5] as List).cast<Meal>(),
      (fields[6] as List).cast<Meal>(),
      (fields[7] as List).cast<Meal>(),
      (fields[8] as List).cast<Meal>(),
      (fields[9] as List).cast<Meal>(),
    );
  }

  @override
  void write(BinaryWriter writer, Diet obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.mealPerDay)
      ..writeByte(2)
      ..write(obj.kcalPerDay)
      ..writeByte(3)
      ..write(obj.monday)
      ..writeByte(4)
      ..write(obj.tuesday)
      ..writeByte(5)
      ..write(obj.wednesday)
      ..writeByte(6)
      ..write(obj.thursday)
      ..writeByte(7)
      ..write(obj.friday)
      ..writeByte(8)
      ..write(obj.saturday)
      ..writeByte(9)
      ..write(obj.sunday);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DietAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
