// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiveLocation.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveLocationAdapter extends TypeAdapter<HiveLocation> {
  @override
  final int typeId = 1;

  @override
  HiveLocation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveLocation(
      locationName: fields[0] as String,
      coordiantes: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveLocation obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.locationName)
      ..writeByte(1)
      ..write(obj.coordiantes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveLocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
