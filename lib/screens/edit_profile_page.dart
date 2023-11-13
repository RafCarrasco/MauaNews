import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mauanews/components/button_widget.dart';
import 'package:mauanews/components/edit_textfield.dart';
import 'package:mauanews/components/text_field.dart';
import 'package:mauanews/screens/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mauanews/utils/colors.dart';
import 'dart:typed_data';

import 'package:mauanews/utils/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key? key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  Map<String, dynamic>? userData;
  Uint8List? _image;
  XFile? photo;
  String imageUrl = '';
  bool isImageDisplayed = false;

  void selectImage() async{
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void _resetPhoto() {
    setState(() {
      imageUrl = '';
      isImageDisplayed = false;
    });
  }

  void _selectPhoto() async {
    final ImagePicker picker = ImagePicker();

    try {
      XFile? file =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 90);
      if (file != null)
        setState(() {
          photo?.readAsBytes();
          photo = file;
          isImageDisplayed = true;
        });
    } catch (e) {
      print(e);
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
        leading: null,
        title: user.displayName != null ?
        Text(user.displayName ?? 'Nome do Usuário')
        :
        Text(userData?['username'] ?? 'Nome do Usuário'),
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
                        SizedBox(
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
                              child: IconButton(
                                onPressed: selectImage,
                                color: primaryColor,
                                icon: const Icon(Icons.add_a_photo_sharp, color: Colors.blue),
                              ),
                              bottom: -10,
                              left: 90,
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        EditTextFieldWidget(
                          label: 'Nome',
                          text: userData['username'],
                          onChanged: (name) {},
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        EditTextFieldWidget(
                          label: 'Biografia',
                          text: userData['bio'],
                          onChanged: (about) {},
                        ), 
                        SizedBox(height: 120,), 
                        ButtonWidget(onTap: () {  }, text: 'Salvar',)                    
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