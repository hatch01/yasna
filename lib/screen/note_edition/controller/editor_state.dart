part of 'editor_bloc.dart';

@immutable
abstract class EditorState {
  final bool readOnly;

  const EditorState({this.readOnly = false});
}

class EditorInitial extends EditorState {
  const EditorInitial({super.readOnly = true});
}

class EditorReadOnly extends EditorState {
  const EditorReadOnly({super.readOnly = true});
}

class EditorEditing extends EditorState{
  const EditorEditing({super.readOnly = false});
}