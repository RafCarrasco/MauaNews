import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final String username;
  final String profileImage;
  final String imageUrl;
  final String caption;

  PostWidget({
    required this.username,
    required this.profileImage,
    required this.imageUrl,
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
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(profileImage),
              ),
              const SizedBox(width: 10),
              Text(
                username,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Image.network(
            imageUrl,
            width: 300,
            height: 300,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  // Lógica para lidar com o botão de "like"
                },
              ),
              IconButton(
                icon: const Icon(Icons.comment),
                onPressed: () {
                  // Lógica para abrir a aba de comentários
                },
              ),
            ],
          ),
          Text(caption),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
