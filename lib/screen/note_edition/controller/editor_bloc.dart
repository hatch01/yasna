// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:meta/meta.dart';

part 'editor_event.dart';

part 'editor_state.dart';

class EditorBloc extends Bloc<EditorEvent, EditorState> {
  static QuillController controller = QuillController.basic();

  EditorBloc() : super(const EditorReadOnly()) {
    on<EditorEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<Edit>((event, emit) {
      emit(const EditorEditing());
    });
    on<Save>((event, emit) {
      emit(const EditorReadOnly(readOnly: true));
    });
  }
}
