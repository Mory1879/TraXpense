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
  double get dayBudget => amount / daysLeft;
  double get todayExpenses => spendings
      .where((element) => element.date.difference(DateTime.now()).inDays == 0)
      .fold(0, (acc, elem) => acc + elem.amount);

  bool get isNegativeTodayBudget => (dayBudget - todayExpenses) < 0;

  String get daysLeftFormatted => daysLeft.toString();
  String get leftBudgetFormatted => formatCurrency.format(leftBudget);
  String get leftForTodayFormatted =>
      formatCurrency.format((dayBudget - todayExpenses));

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

  getSpendingsDbObject() {
    return spendings
        .toList()
        .map((e) => {"date": e.date, "amount": e.amount})
        .toList();
  }
}
