import 'package:hive/hive.dart';

part 'note_header.g.dart';

@HiveType(typeId: 1)
class NoteHeader {
  @HiveField(0)
  String title;

  @HiveField(1)
  String summary;

  NoteHeader({required this.title, required this.summary});

  @override
  String toString() {
    return "title : $title , summary $summary";
  }
}
