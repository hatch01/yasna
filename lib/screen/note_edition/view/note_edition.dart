import 'package:flutter/material.dart';
import 'body.dart';
import 'custom_app_bar.dart';

class NoteEdition extends StatelessWidget {
  const NoteEdition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Body(),
    );
  }
}
