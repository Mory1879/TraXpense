import 'package:intl/intl.dart';

import 'Spending.dart';

class Budget {
  String budgetID;

  double amount;
  DateTime startDate;
  DateTime endDate;
  List<Spending> spendings;

  final formatCurrency =
      new NumberFormat.currency(locale: "ru_RU", symbol: "₽");

  int get daysLeft => endDate.difference(DateTime.now()).inDays;
  double get leftBudget =>
      amount - spendings.fold(0, (acc, elem) => acc + elem.amount);

  String get daysLeftFormatted => daysLeft.toString();
  String get leftBudgetFormatted => formatCurrency.format(leftBudget);
  // TODO: rewrite to deduce today spendings from todya budget
  String get leftForTodayFormatted =>
      formatCurrency.format(leftBudget / daysLeft);

  Budget.fromMap(Map<String, dynamic> data, String budgetID)
      : amount = data["amount"].toDouble(),
        startDate = data["startDate"].toDate(),
        endDate = data['endDate'].toDate(),
        spendings = (data['spendings'] as List)
            .map((e) => Spending(e['amount'].toDouble(), e['date'].toDate()))
            .toList(),
        budgetID = budgetID;

  addSpending(double amount, DateTime date) {
    spendings.add(Spending(amount, date));
  }
}
