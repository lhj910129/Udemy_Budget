import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/widgets/chart.dart';
import 'package:flutter_complete_guide/widgets/transaction_list.dart';
import 'package:flutter_complete_guide/widgets/new_transaction.dart';

import 'models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // //SystemChrome앱에 대한 조명이나 전체설정등을 세팅할 수 잇음.
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.indigoAccent,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            //fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              button: TextStyle(
                color: Colors.white,
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
    Transaction(
      id: 't1',
      title: 'Nike Shoes',
      amount: 130.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'StarBucks',
      amount: 25.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'Nike Shoes',
      amount: 130.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'StarBucks',
      amount: 25.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'Nike Shoes',
      amount: 130.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'StarBucks',
      amount: 25.00,
      date: DateTime.now(),
    ),
  ];

  //최근7일의 거래내역만 반환하는 함수
  List<Transaction> get recentTransactions {
    return _userTransacrtions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    //코드를 작성할때는 값을 알 수 없으니 const는 사용할 수 없음. 하지만이 함수가실행되면 값이 변하지 않을 예정이니 final
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(), //유니크 id 현재시간으로
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

  void _deleteTransaction(String id) {
    setState(() {
      _userTransacrtions.removeWhere((tx) => tx.id == id);
    });
  }

  bool _showChart = false; //차트표시 디폴트값

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape =
        mediaQuery.orientation == Orientation.landscape; //세로모드인지 가로모드인지 구분용

    //앱바
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expenses',
              style: TextStyle(fontFamily: 'OpenSans'),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTrasaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Personal Expenses',
              style: TextStyle(fontFamily: 'OpenSans'),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTrasaction(context),
              ),
            ],
          );

    //트랜잭션 리스트
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransacrtions, _deleteTransaction),
    );

    //페이지 바디
    final pageBody = SingleChildScrollView(
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
        children: <Widget>[
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Show Chart'),
                Switch.adaptive(
                  //안드에선 머테리얼디자인, ios에선 쿠퍼티노로 표시된다.
                  value: _showChart,
                  activeColor: Theme.of(context).accentColor,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  },
                ),
              ],
            ),
          if (!isLandscape)
            Container(
              height: (mediaQuery.size.height - //기기 전체 사이즈
                      appBar.preferredSize.height - //AppBar크기
                      mediaQuery.padding.top) * //상태표시줄 크기
                  0.3,
              child: Chart(
                recentTransactions,
              ),
            ),
          if (!isLandscape) txListWidget,
          if (isLandscape)
            _showChart
                ? Container(
                    height: (mediaQuery.size.height - //기기 전체 사이즈
                            appBar.preferredSize.height - //AppBar크기
                            mediaQuery.padding.top) * //상태표시줄 크기
                        0.7,
                    child: Chart(
                      recentTransactions,
                    ),
                  )
                : txListWidget,
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar, //앱바를 변수로 만든 이유 : 앱바의 높이는 이미 있어서 어디에서나 액세스 할 수 있다.
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTrasaction(context),
                  ),
          );
  }
}
