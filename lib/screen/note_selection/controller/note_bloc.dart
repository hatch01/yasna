import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../component/res.dart';
import 'note.dart';

part 'note_event.dart';

part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  late List<Note> fullNoteList;

  NoteBloc() : super(NoteRetrieving()) {
    fullNoteList = state.noteList;
    print(fullNoteList);
    // on<NoteEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<Filter>((event, emit) {
      emit(NoteFiltering(filter: event.filter, fullNoteList: fullNoteList));
    });
    on<StartFilter>((event, emit) {
      emit(NoteFilterStarting(fullNoteList: fullNoteList));
    });
    on<StopFilter>((event, emit) {
      emit(NoteFilterReseting(fullNoteList: fullNoteList));
    });
  }
}
