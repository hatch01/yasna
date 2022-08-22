// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_core.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteCoreAdapter extends TypeAdapter<NoteCore> {
  @override
  final int typeId = 0;

  @override
  NoteCore read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteCore(
      noteData: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NoteCore obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.noteData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteCoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
