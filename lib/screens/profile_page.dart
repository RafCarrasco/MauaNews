import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mauanews/components/custom_icon_button.dart';
import 'package:mauanews/components/text_box.dart';
import 'package:mauanews/screens/create_post_page.dart';
import 'package:mauanews/screens/edit_profile_page.dart';
import 'package:mauanews/screens/feed.dart';
import 'package:mauanews/screens/login.dart';
import 'package:mauanews/services/auth_service.dart';
import 'package:mauanews/utils/colors.dart';


class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  Map<String, dynamic>? userData;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isGridSelected = true;

  final timestamp = DateTime.now().millisecondsSinceEpoch;

  void signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  void initState() {
    super.initState();

    if (user.providerData[0].providerId == 'password') {
      FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .get()
          .then((snapshot) {
        if (snapshot.exists) {
          setState(() {
            userData = snapshot.data() as Map<String, dynamic>;
          });
        }
      });
    } else {
      FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.email)
          .get()
          .then((snapshot) {
        if (snapshot.exists) {
          setState(() {
            userData = snapshot.data() as Map<String, dynamic>;
          });
        }
      });
    }
  }
  

  void _openDrawer() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          decoration: const BoxDecoration(
            color: backgroundApp,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: secondaryColor,
                  size: 45,
                ),
              ),
              ListTile(
                title: const Text(
                  'Editar Perfil',
                  style: TextStyle(color: textColor),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  'Sair/Deslogar',
                  style: TextStyle(
                    color: Color.fromARGB(255, 177, 40, 30),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  googleSignProv google=googleSignProv();
                  google.logout();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
                },
              ),
            ],
          ),
          );
        });
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: user.displayName != null ?
        Text(user.displayName ?? 'Nome do Usuário', style: const TextStyle(color: Colors.white),)
        :
        Text(userData?['username'] ?? 'Nome do Usuário', style: const TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            
            onPressed: _openDrawer,
          ),
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection('usuarios').doc(user.uid).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.data() != null) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;
                return ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        userData['url'] != null ?
                        CircleAvatar(
                          radius: 65,
                          backgroundImage: NetworkImage(userData['url'] ?? ''),
                        )
                        :
                        CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.transparent,
                          child: ClipRRect(
                            child: Image.asset("assets/images/user_avatar.png"),
                          )
                        ),
                        const SizedBox(height: 8),
                        MyTextBox(
                          text: userData['username'],
                          isBold: true,
                        ),
                        MyTextBox(
                          text: userData['bio'],
                          isBold: false,
                        ),
                      ],
                      )
                    ],
                  );
                }
                else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error${snapshot.error}'),
                  );
                }
                return const Center(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              },
            ),
            _buildUserInfo(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isGridSelected = true;
                    });
                  },
                  child: Icon(
                    Icons.grid_on,
                    size: 32,
                    color: isGridSelected ? primaryColor : Colors.grey,
                  ),
                ),
                
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _buildUserPosts(),
            ),
            _buildFooter(context),
          ],
        ),
      );
    }

    Widget _buildUserInfo() {
      return const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 6,
          ),
          SizedBox(height: 10),
        ]
      );
      }

      Widget _buildUserPosts() {
        if (isGridSelected) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('userPosts')
                .where('userId', isEqualTo: user.uid) 
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
        } else {
          return const Center(
            child: Text('Posts Favoritos'),
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
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => FeedPage()),
                  );
                },
              ),
              CustomIconButton(
                icon: Icons.add_circle_outline_rounded,
                color: primaryColor,
                iconSize: 32,
                onPressed: () {
                  Navigator.pop(
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
      }
    
  