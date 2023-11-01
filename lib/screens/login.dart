import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mauanews/components/button_widget.dart';
import 'package:mauanews/components/imagens_login.dart';
import 'package:mauanews/components/text_field.dart';
import 'package:mauanews/components/text_field_visibility.dart';
import 'package:mauanews/screens/feed.dart';
import 'package:mauanews/screens/recover_password.dart';
import 'package:mauanews/screens/sign_up.dart';
// import 'package:mauanews/services/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mauanews/utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: primaryColor,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: secondTextColor),
            ),
          ),
        );
      },
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        showErrorMessage("Login com o Google cancelado.");
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      if (user != null) {
        // Crie os dados do usuário no Firestore aqui
        createUserDataInFirestore(user.uid, user.email ?? "");
      }

      return user;
    } catch (e) {
      print('Erro ao fazer login com o Google: $e');
      showErrorMessage("Erro ao fazer login com o Google.");
      return null;
    }
  }

  Future<void> signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
      // Navegue para a página de Feed após o login bem-sucedido
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FeedPage()),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      String errorMessage = 'Erro ao fazer login';

      if (e.code == 'user-not-found') {
        errorMessage = 'Usuário não encontrado. Verifique o email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Senha incorreta. Tente novamente.';
      }

      showErrorMessage(errorMessage);
    } catch (e) {
      print(e.toString());
      showErrorMessage('Erro ao fazer login');
    }
  }

  Future<void> createUserDataInFirestore(String userId, String email) async {
    final firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('usuarios').doc(userId).set({
        'email': email,
      });

      await firestore
          .collection('usuarios/$userId/fotos')
          .doc('FotoPerfil')
          .set({
        'url': 'URL da foto de perfil',
      });

      await firestore.collection('usuarios/$userId/fotos').doc('Posts').set({});
    } catch (e) {
      print("Erro ao criar dados no Firestore: $e");
      showErrorMessage("Erro ao criar dados no Firestore");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(height: 0),
                  Image.asset(
                    "assets/images/logo.png",
                    height: 190,
                    width: 290,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Seja bem vindo(a) ao MauaNews!',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 25),

                  MyTextField(
                    controller: emailController,
                    hintText: "Digite seu email",
                    icon: const Icon(Icons.email_outlined, size: 20, color: Colors.grey),
                  ),

                  const SizedBox(height: 25),

                  MyTextFieldWithVisibility(
                    controller: passwordController,
                    hintText: "Digite sua senha",
                    obscureText: true,
                    icon: const Icon(Icons.lock_outlined, size: 20, color: Colors.grey),
                    onPasswordVisibilityChanged: (bool isVisible) {
                      // Faça algo com o estado da visibilidade da senha
                    },
                  ),

                  const SizedBox(height: 25),

                  ButtonWidget(
                    text: "Login",
                    onTap: signUserIn,
                  ),
                  const SizedBox(height: 25),
                  TextButton(
                    child: const Text(
                      'Esqueceu a senha?',
                      style: TextStyle(
                        color: textColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RecoverPassword()),
                      );
                    },
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Não possui uma conta? ",
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      TextButton(
                        child: const Text(
                          "Registre-se",
                          style: TextStyle(
                            color: linkText,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          thickness: 0.7,
                          indent: 25,
                          endIndent: 1,
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        "  Ou realize login com:  ",
                        style: TextStyle(color: textColor),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.7,
                          indent: 1,
                          endIndent: 25,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImagensLogin(
                        onTap: () async {
                          signInWithGoogle();
                        },
                        imagePath: "assets/images/google.png",
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
