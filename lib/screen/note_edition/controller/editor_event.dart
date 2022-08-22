part of 'editor_bloc.dart';

@immutable
abstract class EditorEvent {}

class Edit extends EditorEvent{}
class Save extends EditorEvent{}
class Load extends EditorEvent{}
