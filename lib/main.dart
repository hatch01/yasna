import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:yasna/component/route_res.dart';
import 'package:yasna/screen/note_edition/model/note_core.dart';
import 'package:yasna/screen/note_edition/model/note_header.dart';
import 'package:yasna/screen/note_edition/view/note_edition.dart';

import 'package:yasna/screen/note_selection/view/note_selection.dart';

Future<void> main() async {
  Hive.registerAdapter(NoteHeaderAdapter());
  Hive.registerAdapter(NoteCoreAdapter());
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const NoteSelection();
        },
      ),
      GoRoute(
        path: "${RouteRes.noteEditor}/:path",
        builder: (BuildContext context, GoRouterState state) {
          String path = state.params['path']!;
          return NoteEdition(noteName: path);
        },
      ),
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp.router(
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      );
    });
  }
}
