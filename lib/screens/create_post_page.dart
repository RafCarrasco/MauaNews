import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageUploadPage extends StatefulWidget {
  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  File? imageFile;
  final picker = ImagePicker();
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> uploadImageToFirebase(File image) async {
    final Reference storageRef = _storage.ref().child('images/${DateTime.now()}.png');
    await storageRef.putFile(image);
    final String imageUrl = await storageRef.getDownloadURL();

    // Salvar a URL da imagem no Firestore
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      await _firestore.collection('usuarios').doc(userId).update({
        'fotoPerfil': imageUrl,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha uma Imagem'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (imageFile != null) ...[
              Image.file(
                imageFile!,
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await uploadImageToFirebase(imageFile!);
                  setState(() {
                    imageFile = null;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Imagem enviada com sucesso!'),
                    ),
                  );
                },
                child: Text('Enviar Imagem'),
              ),
            ] else ...[
              ElevatedButton(
                onPressed: getImageFromCamera,
                child: Text('Tirar Foto'),
              ),
              ElevatedButton(
                onPressed: getImageFromGallery,
                child: Text('Escolher da Galeria'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
