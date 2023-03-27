import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function onSubmitted;
  final TextInputType? keyboardType;
  final String labeltext;

  const AdaptativeTextField(
      {super.key,
      required this.controller,
      required this.onSubmitted,
      this.keyboardType = TextInputType.text, 
      required this.labeltext});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
          padding: const EdgeInsets.only(
            bottom: 10
          ),
          child: CupertinoTextField(
              controller: controller,
              onSubmitted: onSubmitted as void Function(String?),
              keyboardType: keyboardType,
              placeholder: labeltext,
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 12
              ),
            ),
        )
        : TextField(
            controller: controller,
            onSubmitted: onSubmitted as void Function(String?),
            keyboardType: keyboardType,
            decoration: InputDecoration(labelText: labeltext),
          );
  }
}
