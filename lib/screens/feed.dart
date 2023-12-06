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
  bool isGridSelected = true;
  final user = FirebaseAuth.instance.currentUser!;

 void getFieldValue() async {
  DocumentReference docRef = FirebaseFirestore.instance.collection('userPosts').doc('R1rNt4foGI4oHENOyU1F');

  try {
    DocumentSnapshot docSnapshot = await docRef.get();

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
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('userPosts').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        final posts = snapshot.data!.docs;

        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index].data() as Map<String, dynamic>;

            return PostWidget(
              userId: post['userId'] ?? '',
              name: post['name'] ?? '',
              profileImage: post['url'] ?? '',
              postId: posts[index].id,
              caption: post['caption'] ?? '',
              imageUrl: post['imageUrl'],

            );
          },
        );
      },
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
              child: _buildPosts(),
          ),
          _buildFooter(context),
        ],
      ),
    );
  }
}


 

