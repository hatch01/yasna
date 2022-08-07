// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../component/res.dart';
import '../model/note.dart';

part 'note_event.dart';

part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  late List<Note> fullNoteList;
  String lastFilter = "";

  NoteBloc() : super(const NoteRetrieving()) {
    fullNoteList = state.noteList;
    if (kDebugMode) {
      print(fullNoteList);
    }
    // on<NoteEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<RetrieveNote>(_onRetrieveNote);
    on<Filter>(_onFilter);
    on<StartFilter>(_onStartFilter);
    on<StopFilter>(_onStopFilter);

    add(RetrieveNote());
  }

  void _onRetrieveNote(event, emit) {
    List<Note> noteList = [
     Note(path:"/",
          key: UniqueKey(),
          couleur: Colors.red,
          date: DateTime(2020, 10, 10, 10, 10),
          title: "mon titre de qualité"),
     Note(path:"/",
          key: UniqueKey(),
          couleur: Colors.green,
          date: DateTime(2020, 11, 11, 11, 11),
          title: "mon titre de qualité le deuxieme"),
     Note(path:"/",
          key: UniqueKey(),
          couleur: Colors.red,
          date: DateTime(2020, 10, 10, 10, 10),
          title: "mon titre de qualité"),
     Note(path:"/",
          key: UniqueKey(),
          couleur: Colors.green,
          date: DateTime(2020, 11, 11, 11, 11),
          title: "mon titre de qualité le deuxieme"),
     Note(path:"/",
          key: UniqueKey(),
          couleur: Colors.red,
          date: DateTime(2020, 10, 10, 10, 10),
          title: "mon titre de qualité"),
     Note(path:"/",
          key: UniqueKey(),
          couleur: Colors.green,
          date: DateTime(2020, 11, 11, 11, 11),
          title: "mon titre de qualité le deuxieme"),
     Note(path:"/",
          key: UniqueKey(),
          couleur: Colors.red,
          date: DateTime(2020, 10, 10, 10, 10),
          title: "mon titre de qualité"),
     Note(path:"/",
          key: UniqueKey(),
          couleur: Colors.green,
          date: DateTime(2020, 11, 11, 11, 11),
          title: "mon titre de qualité le deuxieme"),
     Note(path:"/",
          key: UniqueKey(),
          couleur: Colors.red,
          date: DateTime(2020, 10, 10, 10, 10),
          title: "mon titre de qualité"),
     Note(path:"/",
          key: UniqueKey(),
          couleur: Colors.green,
          date: DateTime(2020, 11, 11, 11, 11),
          title: "mon titre de qualité le deuxieme"),
     Note(path:"/",
          key: UniqueKey(),
          couleur: Colors.red,
          date: DateTime(2020, 10, 10, 10, 10),
          title: "mon titre de qualité"),
     Note(path:"/",
          key: UniqueKey(),
          couleur: Colors.green,
          date: DateTime(2020, 11, 11, 11, 11),
          title: "mon titre de qualité le deuxieme"),
     Note(path:"/",
          key: UniqueKey(),
          couleur: Colors.red,
          date: DateTime(2020, 10, 10, 10, 10),
          title: "mon titre de qualité"),
     Note(path:"/",
          key: UniqueKey(),
          couleur: Colors.green,
          date: DateTime(2020, 11, 11, 11, 11),
          title: "mon titre de qualité le deuxieme"),
     Note(path:"/",
          key: UniqueKey(),
          couleur: Colors.green,
          date: DateTime(2020, 11, 11, 11, 11),
          title: "mon titre de qualité le deuxieme"),
    ];
    fullNoteList = noteList;
    emit(NoteReady(noteList: noteList, searching: false));
  }

  void _onFilter(Filter event, emit) {
    emit(NoteFiltering(noteList: state.noteList, filter: event.filter));
    lastFilter = event.filter;
    List<Note> filteredNoteList = fullNoteList
        .where((element) =>
            element.title.toLowerCase().contains(event.filter) ||
            Res.monthToName[element.date.month]
                .toString()
                .toLowerCase()
                .contains(event.filter) ||
            element.date.toString().toLowerCase().contains(event.filter))
        .toList();
    emit(NoteReady(
        searching: true, noteList: filteredNoteList, filter: event.filter));
  }

  void _onStartFilter(StartFilter event, emit) {
    emit(NoteFilterStarting(noteList: state.noteList, filter: lastFilter));
    add(Filter(filter: lastFilter));
  }

  void _onStopFilter(StopFilter event, emit) {
    emit(NoteFilterReseting(filter: lastFilter));
    emit(NoteReady(noteList: fullNoteList, filter: lastFilter));
  }
}
