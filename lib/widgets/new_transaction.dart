import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/adaptive_flat_button.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx; //userTransaction의 _addTx를 가져오기 위한 아규먼트 추가
  NewTransaction(this.addTx) {
    print('Contructor NewTransaction');
  }

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleControler = TextEditingController();
  final _amountControler = TextEditingController();
  DateTime _selectedDate;

  //_NewTransactionState() {
  //print('Contructor  NewTransactionState Widget');
  //}

  //initState 태초에 빌드될때만 실행한다. 상태변화나 리빌드일땐 안함. 초기데이터 가져올때 보통 사용한다.
  @override
  void initState() {
    print('initstate');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  void _submitData() {
    final enteredTitle = _titleControler.text;
    final enteredAmount = _amountControler.text;

    if ((enteredTitle.isEmpty || enteredAmount.isEmpty) ||
        enteredAmount.isNotEmpty && double.parse(enteredAmount) < 0 ||
        _selectedDate == null) return;

    widget.addTx(enteredTitle, double.parse(enteredAmount), _selectedDate);

    Navigator.of(context).pop(); //추가를 완료하면 모달 닫기
  }

  //DatePicker
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom:
                MediaQuery.of(context).viewInsets.bottom + 10, //하단 키보드를 포함해 +10
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleControler,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Anmount',
                ),
                controller: _amountControler,
                keyboardType: TextInputType.number, //키보드 타입을 숫자입력형태로
                onSubmitted: (_) =>
                    _submitData, //(_)=> 파라미터 사용하지 않을거니까 신경쓰지 말라는 뜻
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen.'
                          : 'Piked Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  AdaptiveFlatButton('Chose Date!', _presentDatePicker)
                ],
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: _submitData,
                child: const Text(
                  'Add',
                ),
                textColor: Theme.of(context).textTheme.button.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}
