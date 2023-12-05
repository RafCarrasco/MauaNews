import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mauanews/components/post_widget.dart';
import 'package:mauanews/screens/create_post_page.dart';
import 'package:mauanews/screens/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/custom_icon_button.dart';
import '../utils/colors.dart';

class FeedPage extends StatefulWidget {
  FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  File? imageFile;
  final user = FirebaseAuth.instance.currentUser!;

 void getFieldValue() async {
  // 1. Obtenha uma referência para o documento
  DocumentReference docRef = FirebaseFirestore.instance.collection('userPosts').doc('R1rNt4foGI4oHENOyU1F');

  try {
    // 2. Obtenha o DocumentSnapshot associado a esse documento
    DocumentSnapshot docSnapshot = await docRef.get();

    // 3. Acesse o campo específico usando data()
    if (docSnapshot.exists) {
       Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      if(data!=null){
        imageFile=data['imageUrl'];
        print('-----------------------');
        print(imageFile);
      }
    } else {
      print('Documento não encontrado');
    }
  } catch (e) {
    print('Erro ao obter valor do campo: $e');
  }
}
   Widget _buildPosts() {
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          // Use o widget de post importado
          return PostWidget(
            username: 'Nome do Usuário',
            imageUrl: Image.network(imageFile.toString()),
            caption: 'Legenda da postagem',
            profileImage: '',
          );
        },
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomIconButton(
            icon: Icons.home,
            color: selectedButtons,
            iconSize: 32,
            onPressed: () {
            },
          ),
          CustomIconButton(
            icon: Icons.search,
            color: primaryColor,
            iconSize: 32,
            onPressed: () {
            },
          ),
          CustomIconButton(
            icon: Icons.add_circle_outline_rounded,
            color: primaryColor,
            iconSize: 32,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreatePostPage(),
                ),
              );
            },
          ),
          CustomIconButton(
            icon: Icons.account_circle_rounded,
            color: primaryColor,
            iconSize: 32,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              height: 42,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: _buildPosts(),
            ),
          ),
          _buildFooter(context),
        ],
      ),
    );
  }
}


 

