import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mauanews/screens/create_post_page.dart';
import 'package:mauanews/screens/profile_page.dart';

import '../components/custom_icon_button.dart';
import '../utils/colors.dart';

class FeedPage extends StatelessWidget {
  FeedPage({Key? key});

  final user = FirebaseAuth.instance.currentUser!;
  final firestore = FirebaseFirestore.instance;
  final userPostsCollection = 'userPosts';
  final usersCollection = 'usuarios';

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
              height: 40,
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

  Widget _buildPosts() {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection(userPostsCollection).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return Center(child: Text('Sem posts disponíveis.'));
        }

        final posts = snapshot.data!.docs;

        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final postSnapshot = posts[index];
            final post = postSnapshot.data() as Map<String, dynamic>;
            final imageUrl = post['imageUrl'] as String;
            final caption = post['caption'] as String;
            final userId = post['userId'] as String;

            return _buildPost(imageUrl, caption, userId);
          },
        );
      },
    );
  }

  Widget _buildPost(String imageUrl, String caption, String userId) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(user.photoURL ?? ''),
              ),
              const SizedBox(width: 10),
              Text(
                user.displayName ?? 'Nome do Usuário',
                style: const TextStyle(fontWeight: FontWeight.bold, color: textColor),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Image.network(
            imageUrl,
            width: 450,
            height: 450,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          Text('$userId - $caption'),
          const SizedBox(height: 10),
          // Aqui você pode adicionar a seção de comentários
          // e o botão "ver mais" conforme necessário.
        ],
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
            onPressed: () {},
          ),
          CustomIconButton(
            icon: Icons.search,
            color: primaryColor,
            iconSize: 32,
            onPressed: () {},
          ),
          CustomIconButton(
            icon: Icons.add_circle_outline_rounded,
            color: primaryColor,
            iconSize: 32,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreatePostPage()),
              );
            },
          ),
          CustomIconButton(
            icon: Icons.account_circle_rounded,
            color: primaryColor,
            iconSize: 32,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
