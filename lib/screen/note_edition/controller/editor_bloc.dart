// ignore_for_file: depend_on_referenced_packages

// import 'dart:js_util/js_util_wasm.dart';

import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:yasna/screen/note_edition/model/note_header.dart';

import '../../../component/main_res.dart';

part 'editor_event.dart';

part 'editor_state.dart';

class EditorBloc extends Bloc<EditorEvent, EditorState> {
  final String notePath;
  QuillController? controller;

  EditorBloc(this.notePath) : super(const EditorInitial()) {
    on<EditorEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<Edit>((event, emit) {
      print("edit !!!!");
      emit(const EditorEditing());
    });
    on<Save>(onSave);
    on<Load>(load);

    // ignore: invalid_use_of_visible_for_testing_member
    add(Load());
  }

  Future<void> load(event, emit) async {
    final documentsDir = await getApplicationDocumentsDirectory();
    if (kDebugMode) {
      print("loadfile : ${documentsDir.path + notePath}");
    }
    File noteFile = File(documentsDir.path + notePath);
    String data = noteFile.readAsStringSync();
    var decodedData = (jsonDecode(data));
    print("data : $data");
    print("decodedData : $decodedData");
    print(decodedData.runtimeType);
    // Document doc = Document();
    Document doc = Document.fromJson(decodedData);
    controller = QuillController(
        document: doc,
        selection: TextSelection(
          baseOffset: doc.length - 1,
          extentOffset: doc.length - 1,
        ));
    print(controller);
    emit(const EditorReadOnly(readOnly: true));
  }

  void onSave(event, emit) async {
    final documentsDir = await getApplicationDocumentsDirectory();
    if (kDebugMode) {
      print("onsave : ${documentsDir.path + notePath}");
    }
    File noteFile = File(documentsDir.path + notePath);
    noteFile.writeAsStringSync(
        jsonEncode(controller!.document.toDelta().toJson()),
        mode: FileMode.write);
    var box = await Hive.openBox<NoteHeader>(MainRes.noteOverViewHiveBoxName);
    NoteHeader? header = box.get(notePath);
    box.close();

    // header.title = Res.controller.document.line
    // print(Res.controller.document.toJS().toString());
    emit(const EditorReadOnly(readOnly: true));
  }
}
