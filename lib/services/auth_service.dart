import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mauanews/screens/feed.dart';
import 'package:platform/platform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final Platform platform = LocalPlatform();
String _getGoogleSignInClientId() {
  if (kIsWeb) {
    return '40028629531-ufr6khkg68a99lhte5ghlroe1k0cfana.apps.googleusercontent.com';
  } else if (platform.isAndroid) {
    return '40028629531-vou6sak9gqo157ep2a0grs7hpu792t32.apps.googleusercontent.com';
  }
  else {
    return '';
  }
}

bool Android() => platform.isAndroid;

final FirebaseAuth _auth = FirebaseAuth.instance;

class googleSignProv extends ChangeNotifier {
  void signInFirestore() async {
    final storage = FirebaseStorage.instance;
    final firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    String? Url;
    if (user != null) {
      final userid = user.uid;
      final Reference storageRef =
          storage.ref().child('userProfile/$userid/${DateTime.now()}.png');

      if (user.photoURL != null) {
        final data = await http.get(Uri.parse(user.photoURL!));
        await storageRef.putData(data.bodyBytes);
        Url = await storageRef.getDownloadURL();
      } else {
        print('Foto do usuario == null');
      }

      final userDoc =
          await firestore.collection('usuarios').doc(user.uid).get();
      if (!userDoc.exists) {
        final us = {
          'email': user.email,
          'username': user.email!.split('@')[0],
          'bio': 'Biografia vazia...',
          'url': Url
        };
        await firestore.collection('usuarios').doc(user.uid).set(us);
      }
    }
  }

  Future isGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: _getGoogleSignInClientId(),
    );
    try {
      final googleUser = await googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(googleAuthCredential);
      if (userCredential.user != null) {
        signInFirestore();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FeedPage()),
        );
      }
    } catch (e) {
      print('Erro ao verificar autenticação do usuário do Google: $e');
    }
  }

  Future logout() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: _getGoogleSignInClientId(),
    );
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}