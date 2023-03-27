import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



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
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text("R\$${tr.value.toString()}", style: const TextStyle(color: Colors.white),)
                      ),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: Theme.of(context).textTheme.titleLarge,),
                  subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red,),
                    onPressed: (){
                      onRemove(tr.id);
                    }, 
                  ),
                ),
                
              );
            }
          ),
    );
  }
}