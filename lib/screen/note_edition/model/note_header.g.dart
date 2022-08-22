// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_header.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteHeaderAdapter extends TypeAdapter<NoteHeader> {
  @override
  final int typeId = 1;

  @override
  NoteHeader read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteHeader(
      title: fields[0] as String,
      summary: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NoteHeader obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.summary);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteHeaderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
