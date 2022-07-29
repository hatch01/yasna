import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

quill.QuillController _controller = quill.QuillController.basic();

class FlutterQuillTest extends StatefulWidget {
  const FlutterQuillTest({Key? key}) : super(key: key);

  @override
  State<FlutterQuillTest> createState() => _FlutterQuillTestState();
}

class _FlutterQuillTestState extends State<FlutterQuillTest> {
  @override
  void initState() {
    var myJSON = jsonDecode(
        '''[{"insert":"salut","attributes":{"code":true}},{"insert":" ca vas b "},{"insert":"ien","attributes":{"italic":true}},{"insert":" ici c'est plutot "},{"insert":"cool","attributes":{"underline":true}},{"insert":"\\n"}]''');
    super.initState();
    _controller = quill.QuillController(
        document: quill.Document.fromJson(myJSON),
        selection: const TextSelection.collapsed(offset: 0));
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("les prints");
      print(jsonEncode(_controller.document.toDelta().toJson()));
      print(_controller.document.toPlainText());
    }
    return Column(
      children: [
        quill.QuillToolbar.basic(controller: _controller),
        TextButton(
            onPressed: () {
              _addEditNote(context,
                  selection: _controller.document.getPlainText(
                      _controller.selection.baseOffset,
                      _controller.selection.extentOffset -
                          _controller.selection.baseOffset));
              /*String text = "plutot";
              int index = _controller.document.toPlainText().indexOf(text);
              _controller.formatText(
                  index,
                  text.length,
                  const quill.Attribute(
                      "custom", quill.AttributeScope.INLINE, "customvalue"));

               */
            },
            child: const Text("addeditNote")),
        TextButton(
            onPressed: () {
              if (kDebugMode) {
                print(jsonEncode(_controller.document.toDelta().toJson()));
              }
            },
            child: const Text("print")),
        Expanded(
          child: quill.QuillEditor(
            customElementsEmbedBuilder: customElementsEmbedBuilder,
            scrollable: true,
            focusNode: FocusNode(),
            autoFocus: true,
            expands: true,
            padding: const EdgeInsets.all(0),
            scrollController: ScrollController(),
            controller: _controller,
            readOnly: false, // true for view only mode
          ),
        )
      ],
    );
  }

  Future<void> _addEditNote(BuildContext context,
      {required String selection}) async {
    final index = _controller.document.toPlainText().indexOf(selection);
    final length = selection.length;
    final block = quill.BlockEmbed.custom(
      ErrorBlockEmbed(_controller.document.getPlainText(index, length)),
    );
    print("!!!");
    // print(quill.get(controller, 0));
    // final offset =
    //     quill.getEmbedNode(controller, controller.selection.start).item1;
    print(block);

    _controller.replaceText(
        index, length, block, TextSelection.collapsed(offset: index));
    print("!!!!!!!!!!!!!!!!");
    print(_controller.document.toDelta());
  }

  Widget customElementsEmbedBuilder(
    BuildContext context,
    quill.QuillController controller,
    quill.CustomBlockEmbed block,
    bool readOnly,
    void Function(GlobalKey videoContainerKey)? onVideoInit,
  ) {
    switch (block.type) {
      case 'error':
        final notes = block.data;
        print("error");
        return Container(
          color: Colors.red,
          child: Text(
            notes,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        );
      default:
        print("default");
        return const SizedBox();
    }
  }
}

class ErrorBlockEmbed extends quill.CustomBlockEmbed {
  ErrorBlockEmbed(String value) : super(noteType, value) {
    print("creation");
    print(noteType);
    print(value);
    print(data);
  }

  static const String noteType = 'error';

  static ErrorBlockEmbed fromDocument(quill.Document document) =>
      ErrorBlockEmbed(jsonEncode(document.toDelta().toJson()));

  String get document => data;
}
