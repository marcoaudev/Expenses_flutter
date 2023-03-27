import 'package:expenses/components/Chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {

  final List<Transaction> recentTransaction;
  const Chart({super.key, required this.recentTransaction});

  List<Map<String, dynamic>> get groupedTransactions{
    return List.generate(7, (index){

      double totalSum = 0.0;


      final weekDay = DateTime.now().subtract(
        Duration(days: index)
      );

      for(var i = 0; i < recentTransaction.length; i++){
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMouth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if(sameDay && sameMouth && sameYear) totalSum += recentTransaction[i].value;
      }

      return{
        'day': DateFormat.E().format(weekDay)[0], 
        'value': totalSum};
    }).reversed.toList(); 
  }

  double get _weekTotal{
    return groupedTransactions.fold(0.0, (sum, tr){
      return sum + tr['value'];
    });
  } 

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactions.map((tr){
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
              label: tr['day'].toString(),
              value: tr['value'],
              percentage: _weekTotal == 0 ? 0 : (tr['value'] as double) / _weekTotal,
            ),
          );
        }).toList()
      ),
    );
  }
}