import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mauanews/components/custom_icon_button.dart';
import 'package:mauanews/screens/create_post_page.dart';
import 'package:mauanews/screens/feed.dart';
import 'package:mauanews/utils/colors.dart';


class UserProfilePage extends StatelessWidget {
  final String userId;
  final String userName;
  

  UserProfilePage({required this.userId, required this.userName});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('$userName', style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [ FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('usuarios').doc(userId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Erro: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Center(
                child: Text('Usuário não encontrado.'),
              );
            } else {
              var userData = snapshot.data!.data() as Map<String, dynamic>;
            print(userData);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  userData['url'] != null
                      ? CircleAvatar(
                          radius: 65,
                          backgroundImage: NetworkImage(userData['url']),
                        )
                      : CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.transparent,
                          child: ClipRRect(
                            child: Image.asset("assets/images/user_avatar.png"),
                          ),
                        ),
                  const SizedBox(height: 16),
                  Text(
                    userData['username'],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userData['bio'],
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const Divider(height: 30, ),
                ],
              );
            }
          },
        ),
        Expanded(
              child: _buildUserPosts(userId),
            ),
          _buildFooter(context),
        ]
      ),
    );
  }

  Widget _buildUserPosts(String userId) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('userPosts')
                .where('userId', isEqualTo: userId) 
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              final posts = snapshot.data!.docs;

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return _buildUserPost(posts[index]);
                },
              );
            },
          );
        }
      }

      Widget _buildUserPost(DocumentSnapshot postSnapshot) {
        final post = postSnapshot.data() as Map<String, dynamic>;
        final imageUrl = post['imageUrl'];
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
          ),
          child: Image.network(
            imageUrl,
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
                }
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
                }
              ),
              CustomIconButton(
                icon: Icons.account_circle_rounded,
                color: selectedButtons,
                iconSize: 32,
                onPressed: () {},
              ),
            ],
          )
          );
          }
      

  
