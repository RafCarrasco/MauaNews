import 'package:flutter/material.dart';
import 'package:mauanews/utils/colors.dart';

class AddImageWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function()? onTap;
  final Color borderColor;

  AddImageWidget({
    this.icon = Icons.add,
    this.text = 'Inserir Imagem',
    this.onTap,
    this.borderColor = secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: borderColor, width: 3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: borderColor,
              size: 50,
            ),
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(
                color: secondTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
