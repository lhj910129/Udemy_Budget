import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/transaction_item.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  const Text('No transactions added yet!'),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView(
            children: transactions
                .map(
                  (e) => TransactionItem(
                    key: ValueKey(e.id), //UniqueKey를 사용하면 리빌드될때마다 바뀌기 때문에 밸류키로 매칭시킨다
                    transaction: e,
                    deleteTransaction: deleteTransaction,
                  ),
                )
                .toList(),
          );

    // ListView.builder(
    //     //10개정도는 ListView(children: <Widget>[])으로 충분하다. 데이터 많을땐 리스트뷰빌더를 사용할 것
    //     itemCount: transactions.length,
    //     itemBuilder: (ctx, index) {
    //       return TransactionItem(
    //         transaction: transactions[index],
    //         deleteTransaction: deleteTransaction,
    //       );
    //     },
    //   );
  }
}
