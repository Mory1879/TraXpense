import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter layout demo',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('TraXpense'),
          ),
          body: Container(
            child: Column(
              children: [Header(), BudgetData(), InputContainer()],
            ),
          ),
        ));
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Expanded(
          flex: 1,
          child: Text(
            'Бюджет',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Дней осталось',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Осталось на день',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        )
      ]),
    );
  }
}

class Budget {
  int amount;
  DateTime startDate;
  DateTime endDate;
  List<Spending> spendings;

  final formatCurrency =
      new NumberFormat.currency(locale: "ru_RU", symbol: "₽");

  int get daysLeft => endDate.difference(DateTime.now()).inDays;
  int get leftBudget =>
      amount - spendings.fold(0, (acc, elem) => acc + elem.amount);

  String get daysLeftFormatted => daysLeft.toString();
  String get leftBudgetFormatted => formatCurrency.format(leftBudget);
  String get leftForTodayFormatted =>
      formatCurrency.format(leftBudget / daysLeft);

  Budget.fromMap(Map<String, dynamic> data)
      : amount = data["amount"],
        startDate = data["startDate"].toDate(),
        endDate = data['endDate'].toDate(),
        spendings = (data['spendings'] as List)
            .map((e) => Spending(e['amount'].toInt(), e['date'].toDate()))
            .toList();
}

class Spending {
  int amount;
  DateTime date;

  Spending(this.amount, this.date);
}

class BudgetData extends StatefulWidget {
  @override
  _BudgetDataState createState() => _BudgetDataState();
}

class _BudgetDataState extends State<BudgetData> {
  Budget currentBudget;

  final databaseReference = Firestore.instance;

  @override
  void initState() {
    String host = Platform.isAndroid ? '10.0.2.2:8080' : 'localhost:8080';

    Firestore.instance.settings(
      host: host,
      sslEnabled: false,
      persistenceEnabled: false,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: StreamBuilder<QuerySnapshot>(
          stream:
              databaseReference.collection("budget").getDocuments().asStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();
            if (snapshot.connectionState == ConnectionState.waiting)
              return new Text('Loading...');

            var lastDocument = snapshot.data.documents.last.data;
            currentBudget = Budget.fromMap(lastDocument);

            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      currentBudget.leftBudgetFormatted,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      currentBudget.daysLeftFormatted,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      currentBudget.leftForTodayFormatted,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )
                ]);
          },
        ));
  }
}

class InputContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Container(
          child: Column(
            children: [InputText(), InputButtons()],
          ),
        ));
  }
}

class InputText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(flex: 1, child: Container());
  }
}

class InputButtons extends StatelessWidget {
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
                                  onPressed: () {},
                                  child: Text(
                                    "7",
                                    style: TextStyle(fontSize: 35.0),
                                  ),
                                ))),
                        Expanded(
                            child: ButtonTheme(
                                height: 100.0,
                                child: OutlineButton(
                                  onPressed: () {},
                                  child: Text(
                                    "8",
                                    style: TextStyle(fontSize: 35.0),
                                  ),
                                ))),
                        Expanded(
                            child: ButtonTheme(
                                height: 100.0,
                                child: OutlineButton(
                                  onPressed: () {},
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
                                  onPressed: () {},
                                  child: Text(
                                    "4",
                                    style: TextStyle(fontSize: 35.0),
                                  ),
                                ))),
                        Expanded(
                            child: ButtonTheme(
                                height: 100.0,
                                child: OutlineButton(
                                  onPressed: () {},
                                  child: Text(
                                    "5",
                                    style: TextStyle(fontSize: 35.0),
                                  ),
                                ))),
                        Expanded(
                            child: ButtonTheme(
                                height: 100.0,
                                child: OutlineButton(
                                  onPressed: () {},
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
                                  onPressed: () {},
                                  child: Text(
                                    "1",
                                    style: TextStyle(fontSize: 35.0),
                                  ),
                                ))),
                        Expanded(
                            child: ButtonTheme(
                                height: 100.0,
                                child: OutlineButton(
                                  onPressed: () {},
                                  child: Text(
                                    "2",
                                    style: TextStyle(fontSize: 35.0),
                                  ),
                                ))),
                        Expanded(
                            child: ButtonTheme(
                                height: 100.0,
                                child: OutlineButton(
                                  onPressed: () {},
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
                            child: ButtonTheme(
                                height: 100.0,
                                child: OutlineButton(
                                  onPressed: () {},
                                  child: Text(
                                    "0",
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
                            onPressed: () {},
                            child: Icon(
                              Icons.backspace,
                              color: Colors.white,
                              size: 24.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                          )),
                      Expanded(
                          flex: 3,
                          child: FlatButton(
                            color: Colors.orangeAccent,
                            onPressed: () {},
                            child: Icon(
                              Icons.keyboard_return,
                              size: 34.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                          ))
                    ],
                  ))
            ])));
  }
}
