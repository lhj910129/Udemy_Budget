import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions; //최근1주 거래내역목록
  Chart(this.recentTransactions); //생성자

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      //7개를 생성하고
      final weekDay = DateTime.now().subtract(
        //현재날짜에서 index를(7로 지정해놓음) subtract(빼기)한다
        Duration(days: index),
      );

      int totalSum = 0; //총금액담는 용도

      //최근1주 거래내역목록중에서
      for (var i = 0; i < recentTransactions.length; i++) {
        //WeekDay와 같은날짜의 금액을 합산한다
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      }; //DateFormat.E(날짜) == 해당 날짜의 요일을 가져온다(M,T,W...)
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[],
      ),
    );
  }
}