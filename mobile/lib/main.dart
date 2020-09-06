import 'package:flutter/material.dart';

import 'package:TraXpense/routes/Landing/Landing.dart';
import 'package:TraXpense/routes/History/History.dart';
import 'package:TraXpense/routes/Settings/Settings.dart';

void main() {
  runApp(MyApp());
}

/* TODO
  1. докинуть модалки
    1.1 если конец бюджета, то создать новый
    1.2 если новый день и остались бабки с прошлого, то дать выбор что с ними делать
    1.3 если стоит чекбок сныканных бабок и они осталить в конце периода,
      то показать модалку, похожу/ на 1.1
*/

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
        home: Landing());
  }
}
