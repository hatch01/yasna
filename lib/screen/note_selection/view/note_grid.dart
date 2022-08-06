import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:yasna/component/loading.dart';
import 'package:yasna/component/main_res.dart';
import 'package:yasna/screen/note_selection/component/res.dart';

import '../controller/note_bloc.dart';
import '../component/note_tile.dart';

class NoteGrid extends StatelessWidget {
  const NoteGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      buildWhen: (lastState, state) => lastState.noteList != state.noteList,
      builder: (context, state) {
        if (state is NoteRetrieving ||
            state is NoteFiltering ||
            state is NoteFilterReseting) {
          return const Loading();
        }
        int index = -1;
        return SingleChildScrollView(
          child: Stack(
            children: state.noteList.map((e) {
              index++;
              int indexModuled = index % 8;
              double padding = 2.w;
              double left = padding;
              double top = 0.01.h;
              double bottom = 0.0;
              double right = 0.0;
              double width = 47.w;
              double height = 47.w;

              double topOneSegment =
                  ((index) / 8).floor() * (4 * height + 5 * padding + 77.w);
              switch (indexModuled) {
                case 0:
                  top = topOneSegment;
                  break;
                case 1:
                  top = topOneSegment;
                  left = width + (2 * padding);
                  right = 0.0;
                  break;
                case 2:
                  top = height + padding + topOneSegment;
                  width = 100.w - (2 * padding);
                  break;
                case 3:
                  top = 2 * height + 2 * padding + topOneSegment;
                  height = 77.w;
                  break;
                case 4:
                  top = 2 * height + 2 * padding + topOneSegment;
                  left = width + (2 * padding);
                  break;
                case 5:
                  top = 3 * height + 3 * padding + topOneSegment;
                  left = width + (2 * padding);
                  height = 77.w;
                  break;
                case 6:
                  top = 2 * height + 3 * padding + 77.w + topOneSegment;
                  break;

                case 7:
                  top = 3 * height + 4 * padding + 77.w + topOneSegment;
                  width = 100.w - (2 * padding);
                  break;
              }
              return AnimatedPadding(
                key: e.key,
                padding: EdgeInsets.only(
                    left: left, top: top, right: right, bottom: bottom),
                duration: MainRes.animationDuration,
                child: AnimatedContainer(
                  key: e.key,
                  height: height,
                  width: width,
                  duration: MainRes.animationDuration,
                  child: NoteTile(
                    tileType: Res.tileTypes[index % 7],
                    note: e,
                    id: index,
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
