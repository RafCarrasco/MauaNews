import 'package:flutter/material.dart';
import 'package:mauanews/utils/colors.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon icon;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        style: const TextStyle(color: secondTextColor),
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          prefixIcon: icon,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: textBoxes),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: textBoxes),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          fillColor: textBoxes,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: secondTextColor),
        ),
      ),
    );
  }
}
