import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mauanews/components/edit_textfield.dart';
import 'package:mauanews/screens/login.dart';



class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key? key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  void signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text(currentUser.displayName ?? 'Nome do Usuário'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              signUserOut(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection("usuarios").doc(currentUser.email).snapshots(),
            builder: (context,  snapshot) {
              if (snapshot.hasData && snapshot.data!.data() != null) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;
                return ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(currentUser.photoURL ?? ''),
                        ),
                        const SizedBox(height: 8),
                        EditTextFieldWidget(
                          label: 'Nome',
                          text: userData['username'],
                          onChanged: (name) {},
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        EditTextFieldWidget(
                          label: 'Biografia',
                          text: userData['bio'],
                          onChanged: (about) {},
                        ),                        
                      ],
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error${snapshot.error}'),
                );
              } return const Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              );
            }
          ),
        ],
      ),
    );
  }
}