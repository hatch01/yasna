import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:yasna/component/main_res.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({Key? key, required this.icon, required this.onTap})
      : super(key: key);
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(1.5.w),
        decoration: const BoxDecoration(
          color: MainRes.buttonBackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Icon(
          icon,
          size: 18.sp,
          color: MainRes.foregroundColor,
        ),
      ),
    );
  }
}
