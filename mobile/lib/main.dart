import 'package:flutter/material.dart';

import 'package:TraXpense/routes/Home/Home.dart';
import 'package:TraXpense/routes/History/History.dart';
import 'package:TraXpense/routes/Settings/Settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/history': (context) => History(),
          '/settings': (context) => Settings(),
        },
        home: Home());
  }
}
