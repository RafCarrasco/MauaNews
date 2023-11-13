import 'package:flutter/material.dart';
import 'package:mauanews/utils/colors.dart';

class MyTextBox extends StatelessWidget {
  final String text;

  const MyTextBox({
    super.key,
    required this.text, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(text, 
            style: TextStyle(color: textColor, fontSize: 18),
          )
        ],
      ),
    );
  }
}