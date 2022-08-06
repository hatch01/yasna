part of 'note_bloc.dart';

abstract class NoteState {
  const NoteState(
      {this.noteList = const [], this.searching = false, this.filter = ""});

  final List<Note> noteList;
  final bool searching;
  final String filter;
}

class NoteFiltering extends NoteState {
  const NoteFiltering(
      {super.noteList = const [],
      super.searching = true,
      required super.filter});
}

class NoteFilterReseting extends NoteState {
  const NoteFilterReseting(
      {super.noteList = const [], super.searching = false, super.filter = ""});
}

class NoteFilterStarting extends NoteState {
  const NoteFilterStarting(
      {super.noteList = const [],
      super.searching = true,
      required super.filter});
}

class NoteRetrieving extends NoteState {
  const NoteRetrieving({super.noteList = const [], super.searching = false});
}

class NoteReady extends NoteState {
  const NoteReady(
      {super.noteList = const [], super.searching = false, super.filter = ""});
}
