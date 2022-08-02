import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'note.dart';

part 'note_event.dart';

part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteRetrieving()) {
    // on<NoteEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
  }
}
