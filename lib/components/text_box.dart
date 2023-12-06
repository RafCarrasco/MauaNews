import 'package:flutter/material.dart';
import 'package:mauanews/utils/colors.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final bool isBold;

  const MyTextBox({
    Key? key,
    required this.text,
    this.isBold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}