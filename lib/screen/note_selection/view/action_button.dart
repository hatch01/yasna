import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../component/main_res.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith(
                (states) => MainRes.backgroundColor),
        elevation: MaterialStateProperty.all(8),
        shape:
        MaterialStateProperty.all<CircleBorder>(const CircleBorder()),
      ),
      child: Icon(Icons.add, size: 30.sp),
    );
  }
}
