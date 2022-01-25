import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/transaction_list.dart';
import "./models/transaction.dart";
import './widgets/new_transaction.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(  // global
        primarySwatch: Colors.blue,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: "Josefin",  // add in pubspec
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith()
        ),
      ),
      home: HomePage(),
    )
  );
}

class HomePage extends StatefulWidget {
  
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showChart = false;

  List _userTransactions = [
    Transaction(
      id: "t1",
      title: "New shoes",
      amount: 50.99,
      date: DateTime.now()
    ),
    Transaction(
      id: "t2",
      title: "Weekly Groceries",
      amount: 18.55,
      date: DateTime.now()
    )
  ];
  // get - dinamicly calculated
  List get _recentTransactions {
    // mxolod is transactions romlebic aris 7 dgeze akhali
    return _userTransactions.where((tr) {  // returns Iterable
      return tr.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7)
        )
      );
    }).toList();
  }

  void _addNewTransaction(String trTitle, double trAmount, DateTime date) {  // _ - private function
    final newTr = Transaction(
      title:trTitle, amount:trAmount, 
      date: date,
      id: DateTime.now().toString()
    );
    setState(() {  // upadate userTransactions state
      _userTransactions.add(newTr);
    });
  }  
  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }
  // show transaction form on FloatinActionButton press
  void _showAddTransaction(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_) {
      // gestureDetector-is nacvlad shesadzloa mxolod NewTransaction-is gamokenebac
      return GestureDetector(
        onTap: () {},
        child: NewTransaction(_addNewTransaction),
        behavior: HitTestBehavior.opaque,
      );
    });
  }
  

  @override
  Widget build(BuildContext context) {
    // final - not rebild this on every render
    // check if display is in landscape mode and use it for show chart
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
   
    return Scaffold(
      appBar: AppBar(
        title: Text("myApp", style: TextStyle(fontWeight: FontWeight.bold),),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: () {},)
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isLandscape) Row(  // toggle bar
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Show Chart"),
                  Switch(
                    value: _showChart, 
                    onChanged: (value) => setState(() {
                      _showChart = value;
                    }),
                  ),
                ]
              ),
              // conditional rendering : chart or transaction list
              if (!isLandscape || _showChart) Container(
                // height: (MediaQuery.of(context).size.height - AppBar().preferredSize.height) * 0.4,
                child: Chart(_recentTransactions),
              ),
              TransactionList(_userTransactions, _deleteTransaction),
            ],
          )
        ),
      ),
      floatingActionButton: false // Platform.isIOS
      ? Container(child: Text(""),)
      : FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white,),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () => _showAddTransaction(context),
      ),
    );
  }
}
