import 'package:flutter/material.dart';
import 'package:personal_expense/Widget/transactionList.dart';
import './Widget/createTransaction.dart';
import './Model/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Personal Expense'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _startTransactionCreationProcess(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return CreateTransaction(_addNewTransaction);
        });
  }

  final List<Transaction> _transactions = [
    Transaction(
      amount: 25.52,
      title: 'food',
      id: '1',
      date: DateTime.now(),
    ),
    Transaction(
      amount: 37.62,
      title: 'petrol',
      id: '2',
      date: DateTime.now(),
    ),
  ];
  void _addNewTransaction(String txTitle, double txAmount) {
    final tx = Transaction(
      amount: txAmount,
      date: DateTime.now(),
      title: txTitle,
      id: (_transactions.length + 1).toString(),
    );
    setState(() {
      _transactions.add(tx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _startTransactionCreationProcess(context);
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startTransactionCreationProcess(context);
        },
      ),
      body: SingleChildScrollView(
        child: (Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                elevation: 10,
                child: Text('Chart'),
              ),
            ),
            Card(
              child: TransactionList(_transactions),
            ),
          ],
        )),
      ),
    );
  }
}
