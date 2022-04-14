import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleControler = TextEditingController();
  final amountControler = TextEditingController();
  final Function addTx; //userTransaction의 _addTx를 가져오기 위한 아규먼트 추가
  NewTransaction(this.addTx);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: '제목',
              ),
              controller: titleControler,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: '금액',
              ),
              controller: amountControler,
            ),
            FlatButton(
              onPressed: () {
                //newtransaction실행
                addTx(
                  titleControler.text,
                  double.parse(amountControler.text),
                );
              },
              child: Text('추가하기'),
              textColor: Colors.purple,
            )
          ],
        ),
      ),
    );
  }
}
