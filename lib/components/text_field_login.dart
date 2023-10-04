import 'package:flutter/material.dart';
import 'package:mauanews/utils/colors.dart';

class EmailTextField extends StatelessWidget {
    final controller;
    final String hintText;
    final bool obscureText;

    const EmailTextField({
      super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        style: const TextStyle(color: Colors.black),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          prefixIcon: const Icon(Icons.email_outlined, size: 20, color: Colors.grey,),
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
            hintStyle: const TextStyle(color: Color.fromARGB(255, 122, 122, 122)),
        ),
      ),
    );
  }
}


class SenhaTextField extends StatelessWidget {
    final controller;
    final String hintText;
    final bool obscureText;

    const SenhaTextField({
      super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        style: const TextStyle(color: Colors.black),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          prefixIcon: const Icon(Icons.lock_outlined, size: 20, color: Colors.grey,),
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
            hintStyle: const TextStyle(color: Color.fromARGB(255, 122, 122, 122)),
        ),
      ),
    );
  }
}

class ConfirmaSenhaTextField extends StatelessWidget {
    final controller;
    final String hintText;
    final bool obscureText;

    const ConfirmaSenhaTextField({
      super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        style: const TextStyle(color: Colors.black),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          prefixIcon: const Icon(Icons.lock_outlined, size: 20, color: Colors.grey,),
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
            hintStyle: const TextStyle(color: Color.fromARGB(255, 122, 122, 122)),
        ),
      ),
    );
  }
}

class UserTextField extends StatelessWidget {
    final controller;
    final String hintText;
    final bool obscureText;

    const UserTextField({
      super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        style: const TextStyle(color: Colors.black),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          prefixIcon: const Icon(Icons.account_circle_rounded, size: 20, color: Colors.grey,),
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
            hintStyle: const TextStyle(color: Color.fromARGB(255, 122, 122, 122)),
        ),
      ),
    );
  }
}