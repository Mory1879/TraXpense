import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/* TODO
  1. прокинуть текущий бюджет в начале
  2. формочка для редактирования суммы и даты
  3. кнопки "изменить этот" и "создать новый бюджет"
    3.1 если "изменить этот", то значения формочки заменяют текущий
    3.2 если "создать новый", то создать новый бюджет
  4. добавить селект с округлением, селект с периодом после которого напоминать
    и чекбок "скрывать округленной"
  5. на выходе (Navigator.pop) выкинуть новый инстанс бюджета 
*/

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final databaseReference = Firestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  void createBudget() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;

    var now = DateTime.now();
    var end = new DateTime(now.year, now.month + 1, now.day);

    // print('user uid: ${uid}');
    // TODO: create budget in DB and check user
    databaseReference.collection("budget").add({
      "amount": 10000,
      "startDate": now,
      "endDate": end,
      "spendings": []
    }).then((value) => print('added'));
  }

  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Назад',
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // TODO: add datepicker adn text with budget per day
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Введите сумму',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Сумма не введена';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          RaisedButton(
            onPressed: () {
              // Validate will return true if the form is valid, or false if
              // the form is invalid.
              createBudget();
              if (_formKey.currentState.validate()) {
                // Process data.
              }
            },
            color: Colors.green,
            child: Text("Создать бюджет"),
          ),
          FlatButton(
              onPressed: () {
                signOut();
              },
              child: Text("Выйти"))
        ],
      ),
    );
  }
}
