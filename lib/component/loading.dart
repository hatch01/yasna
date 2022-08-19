import 'package:flutter/material.dart';
import 'package:yasna/component/main_res.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: MainRes.foregroundColor,
      ),
    );
  }
}
