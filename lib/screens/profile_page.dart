import 'package:flutter/material.dart';
import 'package:mauanews/utils/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PagProfile"),
        backgroundColor: backgroundApp,
      ),
      body: ListView(
        // children: [

        // ],
      ),
    );
  }
}