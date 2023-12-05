import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final String userId;
  final String username;
  final String profileImage;
  final String postId; // Adicionei o campo do postId para recuperar os detalhes do post no Firestore
  final String caption;

  PostWidget({
    required this.userId,
    required this.username,
    required this.profileImage,
    required this.postId,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
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
          _buildUserProfile(),
          const SizedBox(height: 10),
          _buildUserPosts(),
          const SizedBox(height: 10),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildUserProfile() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(profileImage),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          username,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildUserPosts() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('userPosts')
          .where('userId', isEqualTo: userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final posts = snapshot.data!.docs;

        if (posts.isEmpty) {
          return const Text('Nenhum post encontrado para este usuário.');
        }

        return _buildBody(posts);
      },
    );
  }

  Widget _buildBody(List<DocumentSnapshot> posts) {
    // Vou usar apenas o primeiro post da lista para este exemplo.
    final post = posts[0];

    // Aqui, você pode acessar os campos específicos usando o método get
    final imageUrl = post.get('imageUrl');

    return Image.network(
      imageUrl,
      width: double.infinity,
      height: 200,
      fit: BoxFit.cover,
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {
            // Lógica para lidar com o botão de "like"
          },
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.comment),
          onPressed: () {
            // Lógica para abrir a aba de comentários
          },
        ),
      ],
    );
  }
}
