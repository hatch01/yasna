part of 'note_bloc.dart';

@immutable
abstract class NoteEvent {}

class Filter extends NoteEvent {
  Filter({required this.filter});

  final String filter;
}

class StartFilter extends NoteEvent {}

class StopFilter extends NoteEvent {}
