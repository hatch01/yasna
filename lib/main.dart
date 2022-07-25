import 'package:flutter/material.dart';
import 'ViewControllers/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Roboto",
        iconTheme: const IconThemeData(color: Colors.black),
        primaryTextTheme: const TextTheme(
          titleMedium: TextStyle(color: Colors.black),
        ),
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),

    );
  }
}
