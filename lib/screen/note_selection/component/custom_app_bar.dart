import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:yasna/screen/note_selection/controller/note.dart';
import 'package:yasna/screen/note_selection/controller/note.dart';

import '../../../component/main_res.dart';
import '../controller/note_bloc.dart';
import 'res.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        return AppBar(
          backgroundColor: MainRes.backgroundColor,
          elevation: 0,
          title: (state.searching)
              ? Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(2.w),
                      child: Container(
                        height: 10.w,
                        width: 10.w,
                        decoration: BoxDecoration(
                            color: MainRes.buttonBackgroundColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: IconButton(
                            onPressed: () {
                              context.read<NoteBloc>().add(StopFilter());
                            },
                            icon: const Icon(Icons.arrow_back)),
                      ),
                    ),
                    Expanded(child: TextField(
                      onChanged: (text) {
                        context.read<NoteBloc>().add(Filter(filter: text));
                      },
                    )),
                  ],
                )
              : Text(Res.appBarTitle),
          actions: [
            (state.searching)
                ? Container()
                : Padding(
                    padding: EdgeInsets.all(2.w),
                    child: Container(
                      height: 10.w,
                      width: 10.w,
                      decoration: BoxDecoration(
                          color: MainRes.buttonBackgroundColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: IconButton(
                          onPressed: () {
                            context.read<NoteBloc>().add(StartFilter());
                          },
                          icon: const Icon(Icons.search)),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
