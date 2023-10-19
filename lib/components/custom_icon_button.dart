import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Color? color; // Torna a cor opcional
  final VoidCallback onPressed;

  const CustomIconButton(
    {
      super.key,
      required this.icon,
      required this.iconSize,
      required this.onPressed,
      this.color,
    }
  );

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: color,
        size: iconSize,
      ),
      onPressed: onPressed,
    );
  }
}
