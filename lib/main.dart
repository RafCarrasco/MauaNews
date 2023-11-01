import 'package:flutter/material.dart';
import 'package:mauanews/screens/auth_page.dart';
import 'package:mauanews/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final firebaseOptions = DefaultFirebaseOptions.currentPlatform;
  await Firebase.initializeApp(options: firebaseOptions);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: backgroundApp,
        ),
        scaffoldBackgroundColor: backgroundApp
        ),
    );
  }
}
