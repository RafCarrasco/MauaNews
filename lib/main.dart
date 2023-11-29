import 'package:flutter/material.dart';
import 'package:mauanews/screens/auth_page.dart';
import 'package:mauanews/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:mauanews/services/auth_service.dart';

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
    return ChangeNotifierProvider(
      create: (context) => googleSignProv(),   
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundApp,
        colorScheme: const ColorScheme.light().copyWith(
            primary: backgroundApp,
        ),
      )
    )
  );
  }
}