import 'package:hive/hive.dart';

part 'note_core.g.dart';

@HiveType(typeId: 0)
class NoteCore {
  @HiveField(0)
  String noteData;

  NoteCore({required this.noteData});
}
