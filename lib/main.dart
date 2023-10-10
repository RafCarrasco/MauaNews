import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mauanews/screens/auth_page.dart';
import 'package:mauanews/screens/login.dart';
import 'package:mauanews/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBAswooOMuJXHJ1mfUB7pW44zv2F_K2XQI',
        appId: '1:40028629531:web:ca4adda5fcf5deef2626be',
        messagingSenderId: '40028629531',
        projectId: 'mauanews-d80ea',
        storageBucket: 'mauanews-d80ea.appspot.com',
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MauaNews',
        home: AuthPage(),
      );
  }
}

