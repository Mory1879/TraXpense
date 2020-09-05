import 'package:flutter/material.dart';

import 'package:TraXpense/MainScreen/MainScreen.dart';

class InputButtons extends StatelessWidget {
  final Function addDigit;
  final Function addComma;
  final Function removeDigit;
  final Function addSpending;
  final Function clear;

  InputButtons(this.addDigit, this.addComma, this.removeDigit, this.addSpending,
      this.clear);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: Container(
            color: Colors.white,
            child: Row(children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            child: ButtonTheme(
                                height: 100.0,
                                child: OutlineButton(
                                  onPressed: () {
                                    addDigit("7");
                                  },
                                  child: Text(
                                    "7",
                                    style: TextStyle(fontSize: 35.0),
                                  ),
                                ))),
                        Expanded(
                            child: ButtonTheme(
                                height: 100.0,
                                child: OutlineButton(
                                  onPressed: () {
                                    addDigit("8");
                                  },
                                  child: Text(
                                    "8",
                                    style: TextStyle(fontSize: 35.0),
                                  ),
                                ))),
                        Expanded(
                            child: ButtonTheme(
                                height: 100.0,
                                child: OutlineButton(
                                  onPressed: () {
                                    addDigit("9");
                                  },
                                  child: Text(
                                    "9",
                                    style: TextStyle(fontSize: 35.0),
                                  ),
                                )))
                      ],
                    )),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            child: ButtonTheme(
                                height: 100.0,
                                child: OutlineButton(
                                  onPressed: () {
                                    addDigit("4");
                                  },
                                  child: Text(
                                    "4",
                                    style: TextStyle(fontSize: 35.0),
                                  ),
                                ))),
                        Expanded(
                            child: ButtonTheme(
                                height: 100.0,
                                child: OutlineButton(
                                  onPressed: () {
                                    addDigit("5");
                                  },
                                  child: Text(
                                    "5",
                                    style: TextStyle(fontSize: 35.0),
                                  ),
                                ))),
                        Expanded(
                            child: ButtonTheme(
                                height: 100.0,
                                child: OutlineButton(
                                  onPressed: () {
                                    addDigit("6");
                                  },
                                  child: Text(
                                    "6",
                                    style: TextStyle(fontSize: 35.0),
                                  ),
                                )))
                      ],
                    )),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            child: ButtonTheme(
                                height: 100.0,
                                child: OutlineButton(
                                  onPressed: () {
                                    addDigit("1");
                                  },
                                  child: Text(
                                    "1",
                                    style: TextStyle(fontSize: 35.0),
                                  ),
                                ))),
                        Expanded(
                            child: ButtonTheme(
                                height: 100.0,
                                child: OutlineButton(
                                  onPressed: () {
                                    addDigit("2");
                                  },
                                  child: Text(
                                    "2",
                                    style: TextStyle(fontSize: 35.0),
                                  ),
                                ))),
                        Expanded(
                            child: ButtonTheme(
                                height: 100.0,
                                child: OutlineButton(
                                  onPressed: () {
                                    addDigit("3");
                                  },
                                  child: Text(
                                    "3",
                                    style: TextStyle(fontSize: 35.0),
                                  ),
                                )))
                      ],
                    )),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            flex: 2,
                            child: ButtonTheme(
                                height: 100.0,
                                child: OutlineButton(
                                  onPressed: () {
                                    addDigit("0");
                                  },
                                  child: Text(
                                    "0",
                                    style: TextStyle(fontSize: 35.0),
                                  ),
                                ))),
                        Expanded(
                            flex: 1,
                            child: ButtonTheme(
                                height: 100.0,
                                child: OutlineButton(
                                  onPressed: () {
                                    addComma();
                                  },
                                  child: Text(
                                    ",",
                                    style: TextStyle(fontSize: 35.0),
                                  ),
                                ))),
                      ],
                    )),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                          flex: 1,
                          child: FlatButton(
                            color: Colors.grey,
                            onPressed: () {
                              removeDigit();
                            },
                            child: Icon(
                              Icons.backspace,
                              color: Colors.white,
                              size: 24.0,
                              semanticLabel: 'Remove last digit',
                            ),
                          )),
                      Expanded(
                          flex: 3,
                          child: FlatButton(
                            color: Colors.orangeAccent,
                            onPressed: () {
                              addSpending(InputContainer.of(context).amount);
                              clear();
                            },
                            child: Icon(
                              Icons.keyboard_return,
                              size: 34.0,
                              semanticLabel: 'Create expense',
                            ),
                          ))
                    ],
                  ))
            ])));
  }
}
