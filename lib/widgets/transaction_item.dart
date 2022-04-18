import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem(
      {Key key, @required this.transaction, @required this.deleteTransaction})
      : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${transaction.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          '${transaction.title}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          '${DateFormat.yMMMd().format(transaction.date)}',
        ),
        trailing:
            MediaQuery.of(context).size.width > 460 //전체가로길이가 460보다 클때 == 가로모드일때
                ? FlatButton.icon(
                    icon: Icon(Icons.delete),
                    textColor: Theme.of(context).errorColor,
                    label: const Text('Delete'),
                    onPressed: () => deleteTransaction(transaction.id),
                  )
                : IconButton(
                    onPressed: () => deleteTransaction(transaction.id),
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                  ),
      ),
    );
  }
}
