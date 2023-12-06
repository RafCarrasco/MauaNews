import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mauanews/components/button_widget.dart';
import 'package:mauanews/components/edit_textfield.dart';
import 'package:mauanews/screens/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mauanews/screens/profile_page.dart';
import 'package:mauanews/utils/colors.dart';
import 'dart:typed_data';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key? key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final _storage = FirebaseStorage.instance;
  Map<String, dynamic>? userData;
  Map<String, dynamic>? userData2;
  final picker =ImagePicker();
  Uint8List? _image;
  XFile? photo;
  String imageUrl = '';
  bool isImageDisplayed = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  void selectImage() async {
  final user = FirebaseAuth.instance.currentUser!;
  final temp = await picker.pickImage(source: ImageSource.gallery);


  final userid = user.uid;
    final Reference storageRef =
        _storage.ref().child('userProfile/$userid/${DateTime.now()}.png');
    if (temp != null) {
      XFile image = temp;
      final Uint8List data = await image.readAsBytes();
      await storageRef.putData(data);
      String Url = await storageRef.getDownloadURL();
  final userPostsQuery = await FirebaseFirestore.instance
      .collection('userPosts')
      .where('userId', isEqualTo: user.uid)
      .get();

  if (userPostsQuery.docs.isNotEmpty) {
    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in userPostsQuery.docs) {
      await doc.reference.update({
        'url':Url,
      });
    }
  } else {
    await FirebaseFirestore.instance.collection('userPosts').add({
      'userId': user.uid,
      'url': Url,
    });
  }
      FirebaseFirestore.instance.collection('usuarios').doc(user.uid).update({
        'url': Url,
      });
    }
  Uint8List img = await temp!.readAsBytes();
  setState(() {
    _image = img;
  });
}

  void _updateUserProfile(String username,String bio) async {
    print(user.uid);
    try {
      await FirebaseFirestore.instance.collection('usuarios').doc(user.uid).update({
        'username': username,
        'bio': bio,
      });

      setState(() {
        userData?['username'] = username;
        userData?['bio'] = bio;
      });

      final userPostsQuery = await FirebaseFirestore.instance
          .collection('userPosts')
          .where('userId', isEqualTo: user.uid)
          .get();

      if (userPostsQuery.docs.isNotEmpty) {
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc in userPostsQuery.docs) {
          await doc.reference.update({
            'name': username,
          });
        }
      } else {
        await FirebaseFirestore.instance.collection('userPosts').add({
          'userId': user.uid,
          'name': username,
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil atualizado com sucesso!')),
      );
    } catch (error) {
      print('Erro ao atualizar perfil: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao atualizar perfil. Tente novamente!')),
      );
    
    }
  }

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
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text("Editar o perfil",style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection("usuarios").doc(user.uid).snapshots(),
            builder: (context,  snapshot) {
              if (snapshot.hasData && snapshot.data!.data() != null) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;
                return ListView(
                  shrinkWrap: true,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            const SizedBox(height: 10),
                            _image != null ?
                            CircleAvatar(
                              radius: 65,
                              backgroundImage: MemoryImage(_image!),
                            )
                            : user.photoURL != null ?
                            CircleAvatar(
                              radius: 65,
                              backgroundImage: NetworkImage(user.photoURL ?? ''),
                            )
                            :
                            CircleAvatar(
                              radius: 65,
                              backgroundColor: Colors.transparent,
                              child: ClipRRect(
                                child: Image.asset("assets/images/user_avatar.png"),
                              )
                            ),
                            Positioned(
                              bottom: -10,
                              left: 90,
                              child: IconButton(
                                onPressed: selectImage,
                                color: primaryColor,
                                icon: const Icon(Icons.add_a_photo_sharp, color: Colors.blue),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        EditTextFieldWidget(
                          label: 'Nome',
                          text: userData['username'],
                          controller: _usernameController,
                          onChanged: (name) {
                            _usernameController.text = name;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        EditTextFieldWidget(
                          label: 'Biografia',
                          text: userData['bio'],
                          controller: _bioController,
                          onChanged: (about) {
                            _bioController.text = about;
                          },
                        ), 
                        const SizedBox(height: 120,), 
                        ButtonWidget(onTap:() {
                          _updateUserProfile(_usernameController.text,_bioController.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfilePage()),
                          );
                        }, 
                        text: 'Salvar', )                    
                      ],
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error${snapshot.error}'),
                );
              } return const Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              );
            }
          ),
        ],
      ),
    );
  }
}