part of 'note_bloc.dart';

abstract class NoteState {
  late List<Note> noteList = [];
  bool searching = false;
}

class NoteFiltering extends NoteState {
  NoteFiltering({required String filter, required List<Note> fullNoteList}) {
    searching = true;
    noteList = fullNoteList
        .where((element) =>
            element.title.toLowerCase().contains(filter) ||
            Res.monthToName[element.date.month]
                .toString()
                .toLowerCase()
                .contains(filter) ||
            element.date.toString().toLowerCase().contains(filter))
        .toList();
  }
}

class NoteFilterReseting extends NoteState {
  NoteFilterReseting({required List<Note> fullNoteList}) {
    searching = false;
    noteList = fullNoteList;
  }
}

class NoteFilterStarting extends NoteState {
  NoteFilterStarting({required List<Note> fullNoteList}) {
    searching = true;
    if (kDebugMode) {
      print(fullNoteList);
    }
    noteList = fullNoteList;
  }
}

class NoteRetrieving extends NoteState {
  NoteRetrieving() {
    noteList = [
      Note(
          couleur: Colors.red,
          date: DateTime(2020, 10, 10, 10, 10),
          title: "mon titre de qualité"),
      Note(
          couleur: Colors.green,
          date: DateTime(2020, 11, 11, 11, 11),
          title: "mon titre de qualité le deuxieme"),
      Note(
          couleur: Colors.red,
          date: DateTime(2020, 10, 10, 10, 10),
          title: "mon titre de qualité"),
      Note(
          couleur: Colors.green,
          date: DateTime(2020, 11, 11, 11, 11),
          title: "mon titre de qualité le deuxieme"),
      Note(
          couleur: Colors.red,
          date: DateTime(2020, 10, 10, 10, 10),
          title: "mon titre de qualité"),
      Note(
          couleur: Colors.green,
          date: DateTime(2020, 11, 11, 11, 11),
          title: "mon titre de qualité le deuxieme"),
      Note(
          couleur: Colors.red,
          date: DateTime(2020, 10, 10, 10, 10),
          title: "mon titre de qualité"),
      Note(
          couleur: Colors.green,
          date: DateTime(2020, 11, 11, 11, 11),
          title: "mon titre de qualité le deuxieme"),
      Note(
          couleur: Colors.red,
          date: DateTime(2020, 10, 10, 10, 10),
          title: "mon titre de qualité"),
      Note(
          couleur: Colors.green,
          date: DateTime(2020, 11, 11, 11, 11),
          title: "mon titre de qualité le deuxieme"),
      Note(
          couleur: Colors.red,
          date: DateTime(2020, 10, 10, 10, 10),
          title: "mon titre de qualité"),
      Note(
          couleur: Colors.green,
          date: DateTime(2020, 11, 11, 11, 11),
          title: "mon titre de qualité le deuxieme"),
      Note(
          couleur: Colors.red,
          date: DateTime(2020, 10, 10, 10, 10),
          title: "mon titre de qualité"),
      Note(
          couleur: Colors.green,
          date: DateTime(2020, 11, 11, 11, 11),
          title: "mon titre de qualité le deuxieme"),
    ];
    // var box = Hive.box(MainRes.noteOverViewHiveBoxName);
    // String name = box.get('name');
    // DateTime birthday = box.get('birthday');
  }
}
