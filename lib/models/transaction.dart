import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String title;
  final int amount;
  final DateTime date;
  //Transaction이 생성되면 필드값들은 바뀌면 안되니 final

  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });
}
