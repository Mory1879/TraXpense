import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String amount;

  InputText(this.amount);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          alignment: Alignment.bottomRight,
          padding: EdgeInsets.only(right: 10.0),
          child: Text(
            amount,
            style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.w600),
          ),
        ));
  }
}
