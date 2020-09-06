import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:TraXpense/entities/Spending.dart';
import 'package:TraXpense/entities/Budget.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final databaseReference = Firestore.instance;

  Budget currentBudget;

  @override
  Widget build(BuildContext context) {
    currentBudget = ModalRoute.of(context).settings.arguments;

    initializeDateFormatting();

    void removeSpending(int index) async {
      setState(() {
        currentBudget.spendings.removeAt(index);
      });

      await databaseReference
          .collection("budget")
          .document(currentBudget.budgetID)
          .setData({"spendings": currentBudget.getSpendingsDbObject()},
              merge: true);
    }

    void undoRemove(int index, Spending spending) async {
      setState(() {
        currentBudget.spendings.insert(index, spending);
      });

      await databaseReference
          .collection("budget")
          .document(currentBudget.budgetID)
          .setData({"spendings": currentBudget.getSpendingsDbObject()},
              merge: true);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('История трат'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Назад',
          onPressed: () => Navigator.pop(context, currentBudget),
        ),
      ),
      body: ListView.builder(
        itemCount: currentBudget.spendings.length,
        itemBuilder: (context, index) {
          final Spending item = currentBudget.spendings[index];

          return Card(
              child: Dismissible(
                  key: Key(item.hashCode.toString()),
                  onDismissed: (direction) {
                    // Remove the item from the data source.
                    removeSpending(index);

                    // Then show a snackbar.
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Трата в ${item.amount} удалена"),
                        action: SnackBarAction(
                          label: 'Отмена',
                          onPressed: () {
                            undoRemove(index, item);
                          },
                        )));
                  },
                  background: new Container(
                      padding: EdgeInsets.only(right: 20.0),
                      color: Colors.red,
                      child: new Align(
                        alignment: Alignment.centerRight,
                        child: new Text('Удалить',
                            textAlign: TextAlign.right,
                            style: new TextStyle(color: Colors.white)),
                      )),
                  child: ListTile(
                      title: Row(
                    children: [
                      Expanded(
                          child: new RichText(
                        text: new TextSpan(
                          style: new TextStyle(
                            color: Colors.black,
                          ),
                          children: [
                            new TextSpan(
                              text: '${item.amount} ₽',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 35.0),
                            )
                          ],
                        ),
                      )),
                      new RichText(
                        text: new TextSpan(
                          style: new TextStyle(
                            color: Colors.black,
                          ),
                          children: [
                            new TextSpan(
                              text:
                                  '${new DateFormat.yMMMd('ru_RU').add_Hms().format(item.date)}',
                              style: new TextStyle(fontSize: 15.0),
                            )
                          ],
                        ),
                      )
                    ],
                  ))));
        },
      ),
    );
  }
}
