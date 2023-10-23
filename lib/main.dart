import 'package:flutter/material.dart';
import 'package:mauanews/screens/auth_page.dart';
import 'package:mauanews/screens/login.dart';
import 'package:mauanews/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      theme: ThemeData(scaffoldBackgroundColor: backgroundApp),
    );
  }
}
