import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transaction = [
    
  ];

  // String titleInput;
  // String amountInput;
  final titleControler = TextEditingController();
  final amountControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            child: Card(
              //카드의 부모가 크기가 정의되지않았을때 자식의 크기에 맞춰진다.
              color: Colors.blue,
              child: Text('이곳에 차트'),
              elevation: 5,
            ),
          ),
          Card(
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
                      // onChanged: (val){

                      //   titleInput = val;
                      // },//키를 입력할때마다 실행
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: '금액',
                      ),
                      controller: amountControler,
                      // onChanged: (val){
                      //   amountInput = val;
                      // },
                    ),
                    FlatButton(
                      onPressed: () {
                        print(titleControler);
                      },
                      child: Text('추가하기'),
                      textColor: Colors.purple,
                    )
                  ]),
            ),
          ),
          TransactionList()
        ],
      ),
    );
  }
}
