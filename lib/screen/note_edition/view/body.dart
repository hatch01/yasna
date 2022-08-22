import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide EditorState;
import 'package:sizer/sizer.dart';

import '../../../component/main_res.dart';
import '../../../component/toolbar.dart';
import '../component/text_editor.dart';
import '../controller/editor_bloc.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool displayEditor = false;
  bool showOpacity = false;
  late EditorState lastState;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(context).style.copyWith(
            color: MainRes.foregroundColor,
          ),
      child: BlocBuilder<EditorBloc, EditorState>(
        buildWhen: (oldState, newState) {
          return (oldState.readOnly != newState.readOnly) ||
              oldState is EditorInitial;
        },
        builder: (context, state) {
          if (context.read<EditorBloc>().controller == null) {
            lastState = state;
            return const Center(
                child: CircularProgressIndicator(
              color: MainRes.foregroundColor,
            ));
          }
          print(state);
          if (lastState.readOnly != state.readOnly) {
            if (state.readOnly) {
              showOpacity = false;
              Future.delayed(MainRes.animationDuration, () {
                print("first set state");
                setState(() {
                  displayEditor = false;
                });
              });
            } else {
              displayEditor = true;
              Future.delayed(MainRes.animationDuration, () {
                print("second set state");
                setState(() {
                  showOpacity = true;
                });
              });
            }
          }
          lastState = state;
          return Column(
            children: [
              AnimatedContainer(
                duration: MainRes.animationDuration,
                height: displayEditor ? 5.h : 0.0,
                child: AnimatedOpacity(
                  duration: MainRes.animationDuration,
                  opacity: showOpacity ? 1 : 0,
                  child: SizedBox(
                    width: 100.w,
                    child: ToolBar(
                      controller: context.read<EditorBloc>().controller!,
                      iconTheme: QuillIconTheme(
                          iconSelectedColor: MainRes.foregroundColor,
                          iconUnselectedColor: MainRes.foregroundColor,
                          iconUnselectedFillColor: Colors.transparent,
                          iconSelectedFillColor: MainRes.buttonBackgroundColor,
                          disabledIconColor: MainRes.disabledForegroundColor),
                    ),
                  ),
                ),
              ),
              TextEditor(readOnly: state.readOnly),
            ],
          );
        },
      ),
    );
  }
}
