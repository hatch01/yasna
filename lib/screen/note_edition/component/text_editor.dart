import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../controller/editor_bloc.dart';

class TextEditor extends StatelessWidget {
  final bool readOnly;
  const TextEditor({
    Key? key, required this.readOnly
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuillEditor(
      scrollController: ScrollController(),
      expands: false,
      autoFocus: true,
      focusNode: FocusNode(),
      scrollable: true,
      padding: EdgeInsets.zero,
      controller: context.read<EditorBloc>().controller!,
      customStyles: DefaultStyles(
        color: Colors.white,
      ),
      readOnly: readOnly,
    );
  }
}
