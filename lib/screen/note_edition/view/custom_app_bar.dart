import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:yasna/component/custom_icon_button.dart';

import '../../../component/main_res.dart';
import '../controller/editor_bloc.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditorBloc, EditorState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(2.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomIconButton(
                  icon: Icons.arrow_back,
                  onTap: () {
                    GoRouter.of(context).pop();
                  }),
              Container(
                width: 75.w,
                padding: EdgeInsets.only(bottom: 0.8.h),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: context.read<EditorBloc>().textEditingController,
                  readOnly: state.readOnly,
                  decoration: InputDecoration(
                    focusedBorder: (!state.readOnly)
                        ? UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: MainRes.foregroundColor, width: 0.3.h),
                          )
                        : const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                  ),
                  cursorColor: MainRes.foregroundColor,
                  style: const TextStyle(color: MainRes.foregroundColor),
                ),
              ),
              Stack(
                children: [
                  AnimatedOpacity(
                    duration: MainRes.animationDuration,
                    opacity: !state.readOnly ? 0 : 1,
                    child: CustomIconButton(
                        icon: Icons.edit,
                        onTap: () {
                          context.read<EditorBloc>().add(Edit());
                        }),
                  ),
                  if (!state.readOnly)
                    AnimatedOpacity(
                      duration: MainRes.animationDuration,
                      opacity: state.readOnly ? 0 : 1,
                      child: CustomIconButton(
                          icon: Icons.check,
                          onTap: () {
                            context.read<EditorBloc>().add(Save());
                          }),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
