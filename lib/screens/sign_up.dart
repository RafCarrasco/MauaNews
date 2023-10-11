import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mauanews/components/button_widget.dart';
import 'package:mauanews/components/imagens_login.dart';
import 'package:mauanews/components/text_field.dart';
import 'package:mauanews/screens/login.dart';
import 'package:mauanews/utils/colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

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
              message = "As senhas não correspondem",
              style: const TextStyle(color: secondTextColor),
            ),
          ),
        );
      },
    );
  }

  void signUserUp() async{
    showDialog(
      context: context, 
      builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
        );
      },
    );
  
  try {
      if (passwordController.text == confirmpasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
  );
      }else{
        showErrorMessage("message");
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
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
                      obscureText: false,
                      icon: const Icon(Icons.email_outlined, size: 20, color: Colors.grey,),
                    ),

                    const SizedBox(height: 20),

                    MyTextField(
                      controller: passwordController,
                      hintText: "Digite sua senha",
                      obscureText: true,
                      icon: const Icon(Icons.lock_outlined, size: 20, color: Colors.grey,),
                    ),

                    const SizedBox(height: 20),

                    MyTextField(
                      controller: confirmpasswordController,
                      hintText: "Confirme sua senha",
                      obscureText: true,
                      icon: const Icon(Icons.lock_outlined, size: 20, color: Colors.grey,),
                    ),

                    const SizedBox(height: 25),

                    ButtonWidget(
                      text: "Criar Conta",
                      onTap: signUserUp,
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
                      ]
                    ),

                    const SizedBox(height: 15),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImagensLogin(imagePath: "assets/images/google.png"),

                          SizedBox(width: 30),

                          ImagensLogin(imagePath: "assets/images/github.png"),
                      ],
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
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
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