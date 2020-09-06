import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: const Center(
        child: Text(
          'Тут будут настройки',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
