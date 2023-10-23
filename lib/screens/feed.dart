import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mauanews/screens/create_post_page.dart';
import 'package:mauanews/screens/profile_page.dart';
import '../components/custom_icon_button.dart';
import '../utils/colors.dart';

class FeedPage extends StatelessWidget {
  FeedPage({Key? key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const Text('Feed'),
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
    return RefreshIndicator(
      onRefresh: () async {
      },
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buildPost();
        },
      ),
    );
  }

  Widget _buildPost() {
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
          const Row(
            children: [
              CircleAvatar(
                radius: 20,
              ),
              SizedBox(width: 10),
              Text(
                'Nome do Usuário',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Image.network(
            'URL_da_foto_postada',
            width: 300,
            height: 300,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          const Text('Legenda da postagem'),
          const SizedBox(height: 10),
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
                  builder: (context) => ImageUploadPage(),
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
}
