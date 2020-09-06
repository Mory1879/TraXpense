import 'package:flutter/material.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История трат'),
      ),
      body: const Center(
        child: Text(
          'Тут будет история трат',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
