import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mauanews/components/button_widget.dart';
import 'package:mauanews/components/imagens_login.dart';
import 'package:mauanews/components/text_field.dart';
import 'package:mauanews/screens/recover_password.dart';
import 'package:mauanews/screens/sign_up.dart';
import 'package:mauanews/utils/colors.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async{

    showDialog(
      context: context, 
      builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // WRONG EMAIL
      if (e.code == 'user-not-found') {
        // show error to user
        wrongEmailMessage();
      }

      // WRONG PASSWORD
      else if (e.code == 'wrong-password') {
        // show error to user
        wrongPasswordMessage();
      }
    }
  }

  // wrong email message popup
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Email incorreto',
              style: TextStyle(color: secondTextColor),
            ),
          ),
        );
      },
    );
  }

  // wrong password message popup
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Senha incorreta',
              style: TextStyle(color: secondTextColor),
            ),
          ),
        );
      },
    );
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
                  const SizedBox(height: 0,),

                  Image.asset(
                    "assets/images/logoteste2.png",
                    height: 200,
                    width: 300,
                    ),

                  const SizedBox(height: 30),
                  
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
                      obscureText: false,
                      icon: const Icon(Icons.email_outlined, size: 20, color: Colors.grey,),
                    ),

                    const SizedBox(height: 25),

                    MyTextField(
                      controller: passwordController,
                      hintText: "Digite sua senha",
                      obscureText: true,
                      icon: const Icon(Icons.lock_outlined, size: 20, color: Colors.grey,),
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
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RecoverPassword()),
                        );
                      },
                    ),

                    const SizedBox(height: 20),

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
                      ]
                    ),

                    const SizedBox(height: 25),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImagensLogin(imagePath: "assets/images/google.png"),

                          SizedBox(width: 30),

                          ImagensLogin(imagePath: "assets/images/github.png"),
                        ],
                    ),

                    const SizedBox(height: 25),

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
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUp()),
                              );
                            },
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