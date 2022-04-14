import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleControler = TextEditingController();
  final amountControler = TextEditingController();
  final Function addTx; //userTransaction의 _addTx를 가져오기 위한 아규먼트 추가
  NewTransaction(this.addTx);

  void submitData() {
    final enteredTitle = titleControler.text;
    final enteredAmount = amountControler.text;

    if ((enteredTitle.isEmpty || enteredAmount.isEmpty) ||
        enteredAmount.isNotEmpty && int.parse(enteredAmount) < 0) {
      return;
    }

    addTx(
      enteredTitle,
      int.parse(enteredAmount),
    );
  }

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
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: '금액',
              ),
              controller: amountControler,
              keyboardType: TextInputType.number, //키보드 타입을 숫자입력형태로
              onSubmitted: (_) => submitData, //(_)=> 파라미터 사용하지 않을거니까 신경쓰지 말라는 뜻
            ),
            FlatButton(
              onPressed: () {
                submitData();
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
