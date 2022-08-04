import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../component/main_res.dart';
import '../controller/note_bloc.dart';
import 'custom_painter.dart';
import 'res.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>
    with SingleTickerProviderStateMixin {
  double rippleStartX = 0.0, rippleStartY = 0.0;

  bool isInSearchMode = false;

  // intialize animation and controller
  late AnimationController _controller;
  late Animation _animation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.addStatusListener(animationStatusListener);
  }

  // add this method to our DefaultAppBar widget
  animationStatusListener(AnimationStatus animationStatus) {
    print(animationStatus);
    if (animationStatus == AnimationStatus.completed) {
      setState(() {
        print("on passe en mode search");
        isInSearchMode = true;
      });
    }
  }

  void onSearchTapUp(TapUpDetails details) {
    setState(() {
      // context.read<NoteBloc>().add(StartFilter());
      rippleStartX = details.globalPosition.dx;
      rippleStartY = details.globalPosition.dy;
    });

    // run animation controller in forward direction
    // as we now have center point for ripple animation
    _controller.forward();
    print("pointer location $rippleStartX, $rippleStartY");
  }

  // add this method to default app bar class
// this will get executed when user pressed back arrow on search bar
  cancelSearch() {
    // remove search bar from stack
    setState(() {
      isInSearchMode = false;
    });

    // change search value to ''
    onSearchQueryChange('');

    // run the rippple animation in reverse direction
    _controller.reverse();
  }

  onSearchQueryChange(String query) {
    // do anything with this string you can pass it back to Scaffold and
    // handle it there as well, it's up to you
    print('search $query');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        return Stack(
          children: [
            AppBar(
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
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
                    : GestureDetector(
                        onTapUp: onSearchTapUp,
                        child: Padding(
                          padding: EdgeInsets.all(2.w),
                          child: Container(
                              height: 10.w,
                              width: 10.w,
                              decoration: BoxDecoration(
                                  color: MainRes.buttonBackgroundColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: const Icon(Icons.search)),
                        ),
                      ),
              ],
            ),
            // lastly we'll add AnimationBuilder which uses our MyPainter and AnimationController to render ripple animation
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  painter: MyPainter(
                    containerHeight: widget.preferredSize.height,
                    center: Offset(rippleStartX, rippleStartY),
                    // increase radius in % from 0% to 100% of screenWidth
                    radius: _animation.value * 100.w,
                    context: context,
                  ),
                );
              },
            ),
            // search bar depending on whether app bar is in search mode or not
            isInSearchMode
                ? SafeArea(
                    top: true,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isInSearchMode = false;
                            });
                            _controller.reverse();
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        SizedBox(
                          width: 70.w,
                          child: (TextField(
                            onChanged: (text) {
                              context
                                  .read<NoteBloc>()
                                  .add(Filter(filter: text));
                            },
                          )),
                        ),
                      ],
                    ),
                  )
                : (Container())
          ],
        );
      },
    );
  }
}
