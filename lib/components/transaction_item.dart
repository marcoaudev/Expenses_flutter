import 'dart:math';

import'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    super.key,
    required this.tr,
    required this.onRemove,
  });

  final Transaction tr;
  final void Function(String p1) onRemove;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.green,
    Colors.blue,
  ];

  Color? _backgroundColor;

  @override
  void initState(){
    super.initState();
    int i = Random().nextInt(5);
    _backgroundColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text("R\$${widget.tr.value.toString()}", style: const TextStyle(color: Colors.white),)
            ),
          ),
        ),
        title: Text(
          widget.tr.title,
          style: Theme.of(context).textTheme.titleLarge,),
        subtitle: Text(DateFormat('d MMM y').format(widget.tr.date)),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red,),
          onPressed: (){
            widget.onRemove(widget.tr.id);
          }, 
        ),
      ),
      
    );
  }
}