import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/chart.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';
import 'package:flutter_complete_guide/widgets/new_transaction.dart';

import 'models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            //fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransacrtions = [
    // Transaction(
    //   id: 't1',
    //   title: 'Nike Shoes',
    //   amount: 135000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'StarBucks',
    //   amount: 20000,
    //   date: DateTime.now(),
    // ),
  ];

  //최근7일의 거래내역만 반환하는 함수
  List<Transaction> get recentTransactions{
    return _userTransacrtions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

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

  void _startAddNewTrasaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap:
              () {}, //showModalBottomSheet를 탭했을대 이 모달이 닫히지 않도록 온탭에 아무값도 지정하지 않는다.
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque, //안닫히도록 함.
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
          style: TextStyle(fontFamily: 'OpenSans'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTrasaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        /*
        SingleChildScrollView = listView(childiren : [])
        내부 요소들의 크기만큼 스크롤이 가능하게한다.
        
        
        컨테이너로 래핑할 경우
        무조건 사이즈를 지정해야한다. -> 해당사이즈 영역만 스크롤이 가능해진다.
        키보드 높이도 고려해야한다.
        
        ListView(children:[]과 ListView.Builder()의 차이점
        데이터가 셀수없이 많을때 빌더를 사용할것.
        
        */
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(recentTransactions),
            TransactionList(_userTransacrtions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTrasaction(context),
      ),
    );
  }
}
