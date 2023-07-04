// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_songs_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AllsongsModelAdapter extends TypeAdapter<AllsongsModel> {
  @override
  final int typeId = 1;

  @override
  AllsongsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AllsongsModel(
      name: fields[1] as String?,
      artist: fields[2] as String?,
      songId: fields[3] as int?,
      duration: fields[4] as int?,
      uri: fields[5] as String?,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, AllsongsModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.artist)
      ..writeByte(3)
      ..write(obj.songId)
      ..writeByte(4)
      ..write(obj.duration)
      ..writeByte(5)
      ..write(obj.uri);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllsongsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
