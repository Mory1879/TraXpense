import 'package:flutter/material.dart';

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

class Settings extends StatelessWidget {
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
      body: const Center(
        child: Text(
          'Тут будут настройки',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
