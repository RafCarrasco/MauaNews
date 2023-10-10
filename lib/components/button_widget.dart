import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const ButtonWidget({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(21,170,255, 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
