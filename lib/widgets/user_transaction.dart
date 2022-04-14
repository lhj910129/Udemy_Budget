import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';

import '../models/transaction.dart';
import 'new_transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransacrtions = [
    Transaction(
      id: 't1',
      title: '운동화',
      amount: 135000,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: '엽기떡볶이',
      amount: 20000,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String txTitle, int txAmount) {
    //코드를 작성할때는 값을 알 수 없으니 const는 사용할 수 없음. 하지만이 함수가실행되면 값이 변하지 않을 예정이니 final
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(), //유니크
    );

    //이 위젯은 Stateful위젯이라 SetState를 호출할 수 있음
    setState(() {
      _userTransacrtions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction), //Arg형태가 Function이므로 괄호를 포함하기 않는다.
        TransactionList(_userTransacrtions),
      ],
    );
  }
}
