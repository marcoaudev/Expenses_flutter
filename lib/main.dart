// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:expenses/components/Chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';
import 'dart:math';
import 'dart:io';

void main() {
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  final ThemeData tema = ThemeData();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses',
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: tema.textTheme.copyWith(
          displayLarge: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          labelLarge:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transaction = [];
  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _transaction.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: date);

    setState(
      () {
        _transaction.add(newTransaction);
      },
    );

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(onSubmit: _addTransaction);
        });
  }

  _deleteTransaction(String id) {
    setState(() {
      _transaction.removeWhere((tr) {
        return tr.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    Widget _getIconButton(IconData icon, Function() fn) {
      return Platform.isIOS
          ? GestureDetector(onTap: fn, child: Icon(icon))
          : IconButton(icon: Icon(icon), onPressed: fn);
    }

    final actions = [
      if (islandscape)
        _getIconButton(_showChart ? Icons.pie_chart : Icons.list, () {
          setState(() {
            _showChart = !_showChart;
          });
        }),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context),
      )
    ];
    final appBar = AppBar(
      title: const Text("Despesas pessoais"),
      actions: actions,
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    var body = SafeArea(
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          if (!_showChart || !islandscape)
            SizedBox(
              height: availableHeight * (islandscape ? 0.7 : 0.3),
              child: Chart(recentTransaction: _recentTransaction),
            ),
          if (_showChart || !islandscape)
            SizedBox(
              height: availableHeight * (islandscape ? 1 : 0.7),
              child: TransactionList(
                transaction: _transaction,
                onRemove: _deleteTransaction,
              ),
            ),
        ]),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Despesas Pessoais'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: body,
          )
        : Scaffold(
            appBar: appBar,
            body: body,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _openTransactionFormModal(context),
                    child: const Icon(Icons.add),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
