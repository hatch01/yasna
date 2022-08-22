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
            children: [
              CustomIconButton(
                  icon: Icons.arrow_back,
                  onTap: () {
                    GoRouter.of(context).pop();
                  }),
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
