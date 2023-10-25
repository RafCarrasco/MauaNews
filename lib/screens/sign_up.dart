import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mauanews/components/button_widget.dart';
import 'package:mauanews/components/imagens_login.dart';
import 'package:mauanews/components/text_field.dart';
import 'package:mauanews/screens/feed.dart';
import 'package:mauanews/screens/login.dart';
import 'package:mauanews/utils/colors.dart';
import '../components/text_field_visibility.dart';
import '../services/auth_service.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

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

  Future<void> signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center();
      },
    );

    final firestore = FirebaseFirestore.instance;

    try {
      if (passwordController.text == confirmpasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final userDoc =
              await firestore.collection('usuarios').doc(user.uid).get();
          if (!userDoc.exists) {
            final us = {
              'email': emailController.text,
              'senha': passwordController.text
            };
            await firestore.collection('usuarios').doc(user.uid).set(us);
          }
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FeedPage()),
            );
        }
      } else {
        Navigator.pop(context);
        showErrorMessage("As senhas não correspondem");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'email-already-in-use') {
        showErrorMessage(
            "Este e-mail já está cadastrado. Tente fazer login ou recuperar a senha.");
      } else if (e.code == 'invalid-email') {
        showErrorMessage("O e-mail fornecido é inválido.");
      } else if (e.code == 'weak-password') {
        showErrorMessage(
            "A senha é muito fraca. Ela deve conter letras maiúsculas, minúsculas, números e caracteres especiais.");
      } else if (e.code == 'operation-not-allowed') {
        showErrorMessage("Esta operação não é permitida.");
      } else {
        showErrorMessage("Erro ao criar conta: ${e.message}");
      }
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
                  Image.asset(
                    "assets/images/logo.png",
                    height: 190,
                    width: 290,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Vamos criar uma conta para você!',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyTextField(
                    controller: emailController,
                    hintText: "Digite seu email",
                    icon: const Icon(Icons.email_outlined,
                        size: 20, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  MyTextFieldWithVisibility(
                    controller: passwordController,
                    hintText: "Digite sua senha",
                    obscureText: true,
                    icon: const Icon(Icons.lock_outlined,
                        size: 20, color: Colors.grey),
                    onPasswordVisibilityChanged: (bool isVisible) {},
                  ),
                  const SizedBox(height: 20),
                  MyTextFieldWithVisibility(
                    controller: confirmpasswordController,
                    hintText: "Confirme a sua senha",
                    obscureText: true,
                    icon: const Icon(Icons.lock_outlined,
                        size: 20, color: Colors.grey),
                    onPasswordVisibilityChanged: (bool isVisible) {},
                  ),
                  const SizedBox(height: 25),
                  ButtonWidget(
                    text: "Criar Conta",
                    onTap: () {
                      signUserUp();
                    },
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Já possui uma conta?",
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      TextButton(
                        child: const Text(
                          "Faça Login agora",
                          style: TextStyle(
                            color: linkText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
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
                          color: secondaryColor,
                        ),
                      ),
                      Text(
                        "  Ou registre-se com:  ",
                        style: TextStyle(color: textColor),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.7,
                          indent: 1,
                          endIndent: 25,
                          color: secondaryColor,
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
                          try {
                            await AuthService().signInWithGoogle();
                            final user = FirebaseAuth.instance.currentUser;
                            await createUserDataInFirestore(
                                user!.uid, user.email!);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FeedPage()),
                            );
                          } catch (e) {
                            print("Erro ao registrar com o Google: $e");
                            showErrorMessage("Erro ao registrar com o Google");
                          }
                        },
                        imagePath: "assets/images/google.png",
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
