part of 'note_bloc.dart';

@immutable
abstract class NoteState {
  late List<Note> noteList=[];
}

class NoteRetrieving extends NoteState {
  NoteRetrieving(){
    noteList = [
      Note(couleur: Colors.red, date: DateTime(2020, 10,10,10,10), title: "mon titre de qualité"),
      Note(couleur: Colors.green, date: DateTime(2020, 11,11,11,11), title: "mon titre de qualité le deuxieme"),
    ];
    // var box = Hive.box(MainRes.noteOverViewHiveBoxName);
    // String name = box.get('name');
    // DateTime birthday = box.get('birthday');
  }
}
