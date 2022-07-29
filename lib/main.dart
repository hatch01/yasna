import 'package:flutter/material.dart';
import 'package:yasna/functionality/flutter_quill_test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home2(),
    );
  }
}

class Home2 extends StatefulWidget {
  const Home2({
    Key? key,
  }) : super(key: key);

  @override
  State<Home2> createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  Widget body = const FlutterQuillTest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  body = const FlutterQuillTest();
                });
                Navigator.pop(context);
              },
              child: const Text("FlutterQuillTest"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("appbar"),
      ),
      body: body,
    );
  }
}
