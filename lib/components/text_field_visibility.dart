import 'package:flutter/material.dart';
import 'package:mauanews/utils/colors.dart';

class MyTextFieldWithVisibility extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Icon icon;
  final Function(bool) onPasswordVisibilityChanged;

  const MyTextFieldWithVisibility({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.icon,
    required this.onPasswordVisibilityChanged,
  }) : super(key: key);

  @override
  _MyTextFieldWithVisibilityState createState() =>
      _MyTextFieldWithVisibilityState();
}

class _MyTextFieldWithVisibilityState extends State<MyTextFieldWithVisibility> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        style: const TextStyle(color: secondTextColor),
        cursorColor: secondTextColor,
        controller: widget.controller,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          prefixIcon: widget.icon,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
                widget.onPasswordVisibilityChanged(_passwordVisible);
              });
            },
            child: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
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
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: secondTextColor),
        ),
      ),
    );
  }
}
