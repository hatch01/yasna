import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:yasna/screen/note_selection/component/res.dart';

import '../controller/note_bloc.dart';
import 'note_tile.dart';

class NoteGrid extends StatelessWidget {
  const NoteGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        return GridView.custom(
          gridDelegate: SliverQuiltedGridDelegate(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            repeatPattern: QuiltedGridRepeatPattern.inverted,
            pattern: Res.gridPatern,
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index < state.noteList.length) {
                return NoteTile(
                  tileType: Res.tileTypes[index % 7],
                  note: state.noteList[(index % state.noteList.length)],
                  id: index,
                );
              }
              return null;
            },
          ),
          // itemCount: state.noteList.length,
        );
      },
    );
  }
}
