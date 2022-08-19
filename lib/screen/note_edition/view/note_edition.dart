import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yasna/component/main_res.dart';
import '../controller/editor_bloc.dart';
import 'body.dart';
import 'custom_app_bar.dart';

class NoteEdition extends StatelessWidget {
  const NoteEdition({Key? key, required this.noteName}) : super(key: key);

  final String noteName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditorBloc(),
      child: const Scaffold(
        backgroundColor: MainRes.backgroundColor,
        appBar: CustomAppBar(),
        body: Body(),
      ),
    );
  }
}
