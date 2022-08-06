import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../component/main_res.dart';
import '../component/res.dart';
import '../controller/note_bloc.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  double returnOpacity = 0.0;
  double searchOpacity = 1.0;
  double titleOpacity = 1.0;
  double textFieldOpacity = 0.0;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      buildWhen: (previousState, state) =>
          previousState.searching != state.searching,
      builder: (context, state) {
        return AppBar(
            backgroundColor: MainRes.backgroundColor,
            elevation: 0,
            title: Stack(
              fit: StackFit.loose,
              alignment: Alignment.center,
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: AnimatedOpacity(
                        duration: MainRes.animationDuration,
                        opacity: titleOpacity,
                        child: Text(Res.appBarTitle))),
                Align(
                  alignment: Alignment.centerRight,
                  child: AnimatedContainer(
                    duration: MainRes.animationDuration,
                    margin: EdgeInsets.only(right: 3.w),
                    height: 10.w,
                    width: (state.searching) ? 87.w : 10.w,
                    decoration: BoxDecoration(
                        color: MainRes.buttonBackgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(2.w),
                      child: Container(
                        height: 10.w,
                        width: 10.w,
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: AnimatedOpacity(
                          duration: MainRes.animationDuration,
                          opacity: returnOpacity,
                          child: IconButton(
                              onPressed: () {
                                Future.delayed(MainRes.animationDuration, () {
                                  setState(() {
                                    searchOpacity = 1.0;
                                    titleOpacity = 1.0;
                                    context.read<NoteBloc>().add(StopFilter());
                                  });
                                });
                                setState(() {
                                  returnOpacity = 0.0;
                                  textFieldOpacity = 0.0;
                                });
                              },
                              icon: const Icon(Icons.arrow_back)),
                        ),
                      ),
                    ),
                    if (state.searching)
                      Expanded(
                        child: AnimatedOpacity(
                          opacity: textFieldOpacity,
                          duration: MainRes.animationDuration,
                          child: TextField(
                            controller: textEditingController,
                            decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent))),
                            cursorColor: Colors.white,
                            style: const TextStyle(
                              color: Colors.white,
                              decorationColor: Colors.white,
                            ),
                            onChanged: (text) {
                              context
                                  .read<NoteBloc>()
                                  .add(Filter(filter: text));
                            },
                          ),
                        ),
                      )
                    else
                      const Spacer(),
                    Padding(
                      padding: EdgeInsets.all(2.w),
                      child: AnimatedOpacity(
                        duration: MainRes.animationDuration,
                        opacity: searchOpacity,
                        child: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            Future.delayed(MainRes.animationDuration, () {
                              setState(() {
                                returnOpacity = 1.0;
                                textFieldOpacity = 1.0;
                              });
                            });
                            setState(() {
                              searchOpacity = 0.0;
                              titleOpacity = 0.0;
                              context.read<NoteBloc>().add(StartFilter());
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ));
      },
    );
  }
}
