import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'transaction_item.dart';



class TransactionList extends StatelessWidget {

  final List<Transaction> transaction;

  final void Function(String) onRemove; 

  const TransactionList({
    super.key, 
    required this.transaction, 
    required this.onRemove
  });

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty 
    ? LayoutBuilder(
        builder:(ctx, constraints){
          return Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  child: Text(
                    "Nenhuma Transação Cadastrada",
                    style: Theme.of(context).textTheme.displayLarge,
                  )
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: constraints.maxHeight * 0.6,
                child: Image.asset("assets/image/waiting.png", fit: BoxFit.cover,)
              )
            ],
          ); 
        }
      )
    : ListView.builder(
            itemCount: transaction.length,
            itemBuilder: ((context, index) {
              final tr = transaction[index];
              return TransactionItem(tr: tr, onRemove: onRemove);
            }
          ),
    );
  }
}