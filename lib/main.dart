import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mauanews/responsive/mobile_screen_layout.dart';
import 'package:mauanews/responsive/responsivo.dart';
import 'package:mauanews/responsive/web_screen_layout.dart';
import 'package:mauanews/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';

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
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MauaNews',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: fundoMobile,
      ),
      home: const Responsivo(
        mobileScreenLayout: MobileScreenLayout(),
        webScreenLayout: WebScreenLayout(),
      ),
      );
  }
}

