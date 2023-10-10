import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mauanews/components/button_widget.dart';
import 'package:mauanews/screens/profile_page.dart';

class FeedPage extends StatelessWidget {
  FeedPage({super.key});
  
  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //remover depois
      appBar: AppBar(
        actions: [
          IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))
        ],
      ),

      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(height: 25),

                    ButtonWidget(
                      text: "VAI PRO PERFIL",
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProfilePage()),
                        );                          
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}