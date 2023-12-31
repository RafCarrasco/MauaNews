import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mauanews/screens/users_profile.dart';

class PostWidget extends StatefulWidget {
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
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isLiked = false;
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
            _buildUserProfile(context),
            const SizedBox(height: 10),
            _buildUserPosts(),
            const SizedBox(height: 10),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context) {
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
              image: NetworkImage(widget.profileImage),
            ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserProfilePage(userId: widget.userId, userName: widget.name,),
              ),
            );
          },
          child: Text(
            widget.name,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 253, 253, 253), fontSize: 20),
          ),
        )
      ],
    );
  }

  Widget _buildUserPosts() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('userPosts')
          .where('imageUrl', isEqualTo: widget.imageUrl)
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
    final post = posts[0];

    final imageUrl = post.get('imageUrl');

    return Image.network(
      imageUrl,
      width: 500,
      height: 500,
      fit: BoxFit.cover,
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? Colors.red : Colors.white,
              ),
              onPressed: () {
                _handleLike(widget.postId, !isLiked);
                setState(() {
                  isLiked = !isLiked;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 1,),
        Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfilePage(userId: widget.userId, userName : widget.name),
                  ),
                );
              },
              child: Text(
                "${widget.name} " ,
                style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 253, 253, 253),),
              ),
            ),
            Text(
              widget.caption,
              style: const TextStyle( color: Color.fromARGB(255, 150, 150, 150),),
            ),
          ],
        ),
      ],
    );
  }

  void _handleLike(String postId, bool isLiked) {
  }
}
