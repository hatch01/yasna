import 'package:flutter/material.dart';
import 'package:yasna/component/main_res.dart';
import 'package:yasna/screen/note_selection/component/note_grid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../component/custom_app_bar.dart';
import '../controller/note_bloc.dart';

class NoteSelection extends StatelessWidget {
  const NoteSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteBloc(),
      child: Scaffold(
        backgroundColor: MainRes.backgroundColor,
        appBar: const CustomAppBar(),
        body: const NoteGrid(),
      ),
    );
  }
}