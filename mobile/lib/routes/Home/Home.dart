import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:TraXpense/entities/Budget.dart';

import 'ui/Header.dart';
import 'ui/InputButtons.dart';
import 'ui/InputText.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Budget currentBudget;

  final databaseReference = Firestore.instance;

  void getCurrentBudget() {
    databaseReference
        .collection("budget")
        .getDocuments()
        .then((snapshot) => setState(() {
              currentBudget = Budget.fromMap(snapshot.documents.last.data,
                  snapshot.documents.last.documentID);
            }));
  }

  void addSpending(String amount) async {
    currentBudget.addSpending(
        double.parse(amount.replaceAll(new RegExp(r','), '.')), DateTime.now());

    await databaseReference
        .collection("budget")
        .document(currentBudget.budgetID)
        .setData({"spendings": currentBudget.getSpendingsDbObject()},
            merge: true).then((value) => getCurrentBudget());
  }

  @override
  void initState() {
    String host = Platform.isAndroid ? '10.0.2.2:8080' : 'localhost:8080';

    Firestore.instance.settings(
      host: host,
      sslEnabled: false,
      persistenceEnabled: false,
    );

    super.initState();

    getCurrentBudget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TraXpense'),
          leading: IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Траты',
            onPressed: () => Navigator.pushNamed(context, '/history',
                    arguments: currentBudget)
                .then((value) => setState(() {
                      currentBudget = value;
                    })),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Настройки',
              onPressed: () => Navigator.pushNamed(context, '/settings'),
            ),
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Header(),
              BudgetData(currentBudget),
              InputContainer(addSpending)
            ],
          ),
        ));
  }
}

class BudgetData extends StatelessWidget {
  final Budget currentBudget;

  BudgetData(this.currentBudget);

  @override
  Widget build(BuildContext context) {
    if (currentBudget == null) {
      return Container(
          margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Center(
              child: Text("Загружаем данные"),
            )
          ]));
    }

    return Container(
        margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Expanded(
            flex: 1,
            child: Text(
              currentBudget.leftBudgetFormatted,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              currentBudget.daysLeftFormatted,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              currentBudget.leftForTodayFormatted,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: currentBudget.isNegativeTodayBudget
                      ? Colors.red
                      : Colors.black),
            ),
          )
        ]));
  }
}

class InputContainer extends StatefulWidget {
  final Function addSpending;

  InputContainer(this.addSpending);

  static _InputContainerState of(BuildContext context) {
    return context.findAncestorStateOfType<_InputContainerState>();
  }

  @override
  State<StatefulWidget> createState() => new _InputContainerState();
}

class _InputContainerState extends State<InputContainer> {
  String amount = "0";

  void addDigit(String value) {
    setState(() {
      if (amount == "0") {
        this.amount = value;
      } else {
        this.amount += value;
      }
    });
  }

  void addComma() {
    if (amount.contains(",")) return;
    setState(() {
      this.amount += ",";
    });
  }

  void removeDigit() {
    if (this.amount == "0") return;
    setState(() {
      String amountLeft = amount.substring(0, amount.length - 1);
      if (amountLeft.isEmpty) {
        this.amount = "0";
      } else {
        this.amount = amountLeft;
      }
    });
  }

  void clear() {
    setState(() {
      this.amount = "0";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Container(
          child: Column(
            children: [
              InputText(amount),
              InputButtons(addDigit, addComma, removeDigit,
                  this.widget.addSpending, clear)
            ],
          ),
        ));
  }
}
