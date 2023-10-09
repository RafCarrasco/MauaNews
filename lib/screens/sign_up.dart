import 'package:flutter/material.dart';
import 'package:mauanews/components/button_widget.dart';
import 'package:mauanews/components/imagens_login.dart';
import 'package:mauanews/components/text_field.dart';
import 'package:mauanews/screens/login.dart';
import 'package:mauanews/utils/colors.dart';
import 'feed.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  void login(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  const SizedBox(height: 25),

                  Image.asset(
                    "assets/images/logo.png",
                    height: 100,
                    width: 100,
                    ),

                  const SizedBox(height: 30),
                  
                  Text(
                    'Seja bem vindo(a) ao MauaNews!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 25),

                    MyTextField(
                      controller: usernameController,
                      hintText: "Digite o seu nome de usuario",
                      obscureText: false,
                      icon: const Icon(Icons.account_circle_rounded, size: 20, color: Colors.grey,),
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

                    MyTextField(
                      controller: confirmpasswordController,
                      hintText: "Confirme sua senha",
                      obscureText: true,
                      icon: const Icon(Icons.lock_outlined, size: 20, color: Colors.grey,),
                    ),

                    const SizedBox(height: 25),

                    ButtonWidget(
                      text: "Criar Conta",
                      onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                    ),

                    const SizedBox(height: 15),

                    const Row(
                      children: <Widget>[
                          Expanded(
                              child: Divider(
                                thickness: 0.7,
                                indent: 25,
                                endIndent: 1,
                                color: corSecundaria,
                              ),
                          ),       

                          Text(
                            "  Ou registre-se com:  ",
                            style: TextStyle(color: corSecundaria),
                            ),        

                          Expanded(
                              child: Divider(
                                thickness: 0.7,
                                indent: 1,
                                endIndent: 25,
                                color: corSecundaria,
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
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}