import 'package:flutter/material.dart';
import 'package:mauanews/utils/dimensoes.dart';

class Responsivo extends StatelessWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  const Responsivo({Key? key,
  required this.webScreenLayout,
  required this.mobileScreenLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        if(constraints.maxWidth > webScreenSize){
          return webScreenLayout;
        }
        return mobileScreenLayout;
      },
    );
  }
}