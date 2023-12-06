import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final String userId;
  final String name;
  final String profileImage;
  final String postId;
  final String caption;
  final String imageUrl;

  PostWidget({
    required this.userId,
    required this.name,
    required this.profileImage,
    required this.postId,
    required this.caption,
    required this.imageUrl,
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
      child: Container(
        constraints: const BoxConstraints(minHeight: 600, maxHeight: 650),
        width: 500,
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
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 253, 253, 253),),
        ),
      ],
    );
  }

  Widget _buildUserPosts() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('userPosts')
          .where('imageUrl', isEqualTo: imageUrl)
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
      width: 500,
      height: 500,
      fit: BoxFit.cover,
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.white),
              onPressed: () {
                // Lógica para lidar com o botão de "like"
              },
            ),
            IconButton(
              icon: const Icon(Icons.comment, color: Colors.white),
              onPressed: () {
                // Lógica para abrir a aba de comentários
              },
            ),
          ],
        ),
        const SizedBox(height: 1,),
        Row(
          children: [
            Text(
              "$name " ,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 253, 253, 253),),
            ),
            Text(
              caption,
              style: const TextStyle( color: Color.fromARGB(255, 150, 150, 150),),
            ),
          ],
        ),
      ],
    );
  }
}
