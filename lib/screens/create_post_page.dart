import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mauanews/components/add_image_widget.dart';
import 'package:mauanews/services/auth_service.dart';
import 'package:mauanews/utils/colors.dart';
import 'package:mauanews/screens/feed.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  File? imageFile;
  XFile? imageFileWeb;
  String? Url;
  Map<String, dynamic>? userData;
  final picker = ImagePicker();
  final _storage = FirebaseStorage.instance;
  final _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  TextEditingController captionController = TextEditingController();
  bool isCaptionVisible = false;
  bool isAndroid = false;
  bool isWeb = false;
  bool uploading = false;

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        isCaptionVisible = true;
      });
    }
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Url = pickedFile.path;
      setState(() {
        imageFileWeb = pickedFile;
        imageFile = File(pickedFile.path);
        isCaptionVisible = true;
      });
    }
  }

  Future<void> uploadImageToFirebase() async {
    if (imageFile != null && user != null) {
      FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user!.uid)
          .get()
          .then((snapshot) {
        if (snapshot.exists) {
          userData = snapshot.data() as Map<String, dynamic>;
        }
      });
      final userId = user!.uid;
      final Reference storageRef =
          _storage.ref().child('userPosts/$userId/${DateTime.now()}.png');
      if (isAndroid) {
        await storageRef.putFile(imageFile!);
      } else if (isWeb) {
        try {
          final Uint8List data = await imageFileWeb!.readAsBytes();
          await storageRef.putData(data);
        } catch (e) {
          print(e);
        }
      } else {
        print('Operação de upload de arquivo não suportada nesta plataforma.');
      }
      final String imageUrl = await storageRef.getDownloadURL();
      final String caption = captionController.text;
      await _firestore.collection('userPosts').add({
        'userId': userId,
        'imageUrl': imageUrl,
        'caption': caption,
        'comments': [],
        'dataPost': FieldValue.serverTimestamp(),
        'name': userData!['username'],
        'picture': userData!['url'],
      });

      setState(() {
        uploading = false;
        imageFile = null;
        captionController.clear();
        isCaptionVisible = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FeedPage()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      isWeb = true;
    } else {
      isAndroid = Android();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Nova publicação', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (imageFile != null) ...[
              Container(
                width: 500,
                height: 500,
                child: isAndroid
                    ? Image.file(
                        imageFile!,
                        fit: BoxFit.cover,
                      )
                    : isWeb
                        ? Image.network(
                            Url!,
                            fit: BoxFit.cover,
                          )
                        : const Placeholder(),
              ),
              if (isCaptionVisible) ...[
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextField(
                    controller: captionController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Legenda da foto',
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    setState(() {
                      uploading = true;
                    });

                    await uploadImageToFirebase();

                    setState(() {
                      uploading = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  icon: Icon(
                    uploading ? Icons.hourglass_empty : Icons.send,
                  ),
                  label: uploading
                      ? const Text('Enviando...')
                      : const Text('Enviar Imagem'),
                ),
              ],
            ] else ...[
              if (isAndroid)
                AddImageWidget(
                  icon: Icons.camera_alt,
                  text: 'Tirar Foto',
                  onTap: getImageFromCamera,
                  borderColor: secondaryColor,
                ),
              const SizedBox(height: 15),
              AddImageWidget(
                icon: Icons.camera_alt,
                text: 'Escolher da galeria',
                onTap: getImageFromGallery,
                borderColor: secondaryColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
