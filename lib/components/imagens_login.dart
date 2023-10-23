import 'package:flutter/material.dart';

class ImagensLogin extends StatelessWidget {
  final Function()? onTap;
  final String imagePath;
  
  const ImagensLogin({
    super.key,
    required this.imagePath, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white,),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        
        child: Image.asset(
          imagePath,
          height: 40,
          width: 40,
        ),
      ),
    );
  }
}


