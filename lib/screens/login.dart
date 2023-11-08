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
import 'package:mauanews/services/auth_service.dart';
import 'package:mauanews/utils/colors.dart';
import 'package:platform/platform.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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

  final Platform platform = LocalPlatform();

  String ClientId() {
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
                    icon: const Icon(Icons.email_outlined,
                        size: 20, color: Colors.grey),
                  ),
                  const SizedBox(height: 25),
                  MyTextFieldWithVisibility(
                    controller: passwordController,
                    hintText: "Digite sua senha",
                    obscureText: true,
                    icon: const Icon(Icons.lock_outlined,
                        size: 20, color: Colors.grey),
                    onPasswordVisibilityChanged: (bool isVisible) {
                      // Faça algo com o estado da visibilidade da senha
                    },
                  ),
                  const SizedBox(height: 25),
                  ButtonWidget(
                    text: "Login",
                    onTap: () async {
                      try {
                        await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => FeedPage()),
                        );
                      } catch (e) {
                        showErrorMessage("Falha no login. Verifique suas credenciais.");
                      }
                    },
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
                        MaterialPageRoute(
                            builder: (context) => RecoverPassword()),
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
                          final provider = Provider.of<googleSignProv>(context,
                              listen: false);
                          provider.isGoogle(context);
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