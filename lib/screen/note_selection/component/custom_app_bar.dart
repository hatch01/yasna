import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../component/main_res.dart';
import 'res.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget{
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MainRes.backgroundColor,
      elevation: 0,
      title: Text(Res.appBarTitle),
      actions: [
        Padding(
          padding: EdgeInsets.all(2.w),
          child: Container(
              height: 10.w,
              width: 10.w,
              decoration: BoxDecoration(
                  color: MainRes.buttonColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.search))),
        )
      ],
    );
  }
}
