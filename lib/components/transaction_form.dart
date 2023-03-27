import 'package:expenses/components/Adaptative_buttom.dart';
import 'package:expenses/components/Adaptative_datepicker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Adaptative_textfield.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm({required this.onSubmit, super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate;

  _onSubmitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    final date = _selectedDate;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, date!);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom
            ),
            child: Column(
              children: <Widget>[
                AdaptativeTextField(
                  controller: _titleController,
                  onSubmitted: (_) => _onSubmitForm(),
                  labeltext: 'título',
                ),
                AdaptativeTextField(
                  controller: _valueController,
                  onSubmitted: (_) => _onSubmitForm(),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  labeltext: "Valor R\$",
                ),
                AdaptativeDatePicker(
                  selectedDate: _selectedDate, 
                  onDateChanged: (newDate){
                    setState(() {
                      _selectedDate = newDate;
                    });
                  }
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AdaptativeButton(
                      label: "Nova Transação",
                      onPressed: _onSubmitForm,
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
