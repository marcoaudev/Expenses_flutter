import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  const AdaptativeButton(
      {super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressed as void Function(), 
            color: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(
              horizontal: 20
            ),
            child: Text(label),
          )
        : ElevatedButton(
            onPressed: onPressed as void Function(),
            child: Text(
              label,
              style:
                const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          );
  }
}
