import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:platform/platform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mauanews/screens/feed.dart';

final Platform platform = const LocalPlatform();
String _getGoogleSignInClientId() {
  if (kIsWeb) {
    return '40028629531-ufr6khkg68a99lhte5ghlroe1k0cfana.apps.googleusercontent.com';
  } else if (platform.isAndroid) {
    return '40028629531-vou6sak9gqo157ep2a0grs7hpu792t32.apps.googleusercontent.com';
  }
  // else if (platform.isIOS) {
  //   return 'YOUR_IOS_CLIENT_ID';
  // }
  else {
    // Defina um valor padrão para outras plataformas (se necessário).
    return '';
  }
}

class AuthService {
  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? gUser =
        await GoogleSignIn(clientId: _getGoogleSignInClientId()).signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    FirebaseAuth.instance.signInWithCredential(credential);
    final firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('object');
      final userDoc =
          await firestore.collection('usuarios').doc(user.email).get();
      if (!userDoc.exists) {
        print('object2');
        final us = {'email': user.email, 'senha': user.uid};
        await firestore.collection('usuarios').doc(user.email).set(us);
      }
    }
                Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FeedPage()),
          );
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class googleSignProv extends ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: _getGoogleSignInClientId(),
  );
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;
  Future<bool> isGoogleUserAuthenticated() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Verifica se o usuário está autenticado com a credencial do Google.
      if (user.providerData.any((info) => info.providerId == 'google.com')) {
        final firestore = FirebaseFirestore.instance;
        final userDoc =
            await firestore.collection('usuarios').doc(user.email).get();
        if (!userDoc.exists) {
          final us = {'email': user.email, 'senha': user.uid};
          await firestore.collection('usuarios').doc(user.email).set(us);
        }
        return true;
      }
    }
    return false;
  }

  Future<void> checkEmailAndLoginWithGoogle(BuildContext context) async {
      try {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;

        final googleAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(googleAuthCredential);

        if (userCredential.user != null) {
          final isGoogleUserAu = await isGoogleUserAuthenticated();
          if (isGoogleUserAu) {
            // O usuário está autenticado com o Google.
            print('Usuário autenticado com o Google');
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FeedPage()),
            );
          } else {
            print('Usuário não está autenticado com o Google');
          }
        }
      } catch (googleSignInError) {
        print('Erro ao fazer login com o Google: $googleSignInError');
        // Reinicie o aplicativo em caso de erro.
      }
    }

      Future<void>loginButton(BuildContext context)async{
              final firestore = FirebaseFirestore.instance;
            final userDoc =
                await firestore.collection('usuarios').doc(user.email).get();
                if(userDoc.exists){
                            Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FeedPage()),
              );
    }
  }

  Future<bool> isGoogle() async {
    try {
      print("erro1");
      final googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      print("erro2");
      final AuthCredential googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print("erro3");
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(googleAuthCredential);
      print("erro4");
      if (userCredential.user != null) {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null &&
            user.providerData.any((info) => info.providerId == 'google.com')) {
          print("erro1");
          return true; 
        }
      }
    } catch (e) {
      print('Erro ao verificar autenticação do usuário do Google: $e');
    }
    return false;
  }
}