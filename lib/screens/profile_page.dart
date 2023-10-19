import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mauanews/screens/feed.dart';
import 'package:mauanews/screens/login.dart';
import '../components/custom_icon_button.dart';
import '../utils/colors.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key});

  final user = FirebaseAuth.instance.currentUser!;

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
        title: Text(user.displayName ?? 'Nome do Usuário'),
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
          _buildUserProfile(),
          Expanded(
            child: _buildUserPosts(),
          ),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildUserProfile() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(user.photoURL ?? ''),
        ),
        Text(
          user.displayName ?? 'Nome do Usuário',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Seguidores: 100'),
            SizedBox(width: 20),
            Text('Seguindo: 50'),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildUserPosts() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        return _buildUserPost();
      },
    );
  }

  Widget _buildUserPost() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Image.network(
        'URL_da_foto_postada',
        fit: BoxFit.cover,
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
            color: primaryColor,
            iconSize: 32,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FeedPage()),
              );
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
            },
          ),
          CustomIconButton(
            icon: Icons.account_circle_rounded,
            color: selectedButtons,
            iconSize: 32,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
