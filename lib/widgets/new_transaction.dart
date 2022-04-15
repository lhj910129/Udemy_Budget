import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx; //userTransaction의 _addTx를 가져오기 위한 아규먼트 추가
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleControler = TextEditingController();

  final amountControler = TextEditingController();

  void submitData() {
    final enteredTitle = titleControler.text;
    final enteredAmount = amountControler.text;

    if ((enteredTitle.isEmpty || enteredAmount.isEmpty) ||
        enteredAmount.isNotEmpty && int.parse(enteredAmount) < 0) {
      return;
    }

    widget.addTx(
      enteredTitle,
      int.parse(enteredAmount),
    );

    Navigator.of(context).pop();//추가를 완료하면 모달 닫기
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
              child: Text('추가'),
              textColor: Theme.of(context).accentColor,
            )
          ],
        ),
      ),
    );
  }
}
