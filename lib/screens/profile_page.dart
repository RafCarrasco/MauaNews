import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mauanews/utils/colors.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundApp,
      ),
      body: Center(
          child: Text(
        "LOGGED IN AS: " + user.email!,
          )
      ),
    );
  }
}