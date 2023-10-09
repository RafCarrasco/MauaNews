import 'package:flutter/material.dart';
import 'package:mauanews/components/button_widget.dart';
import 'package:mauanews/components/imagens_login.dart';
import 'package:mauanews/components/text_field.dart';
import 'package:mauanews/utils/colors.dart';

class FeedPage extends StatelessWidget {
  FeedPage({super.key});
  
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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

                    // MyTextField(
                    //   controller: usernameController,
                    //   hintText: "Email:",
                    //   obscureText: false,
                    // ),

                    // const SizedBox(height: 25),

                    // MyTextField(
                    //   controller: passwordController,
                    //   hintText: "Senha",
                    //   obscureText: true,
                    // ),

                    const SizedBox(height: 25),

                    // ButtonLogin(
                    //   onTap: login,
                    // ),

                    const SizedBox(height: 25),

                  TextButton(
                    child: const Text(
                      'Esqueceu a senha?',
                      style: TextStyle(
                        color: Color.fromARGB(255, 81, 81, 81),
                        decoration: TextDecoration.underline,
                        ),
                      ),
                      onPressed: (){
                        print("jorge");
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
                                color: corSecundaria,
                              ),
                          ),       

                          Text(
                            "  Ou realize login com:  ",
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

                    const SizedBox(height: 25),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImagensLogin(imagePath: "/images/google.png"),

                          SizedBox(width: 35),

                          ImagensLogin(imagePath: "/images/facebook_logo.png"),
                        ],
                    ),

                    const SizedBox(height: 25),

                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Não possui uma conta? ",
                          style: TextStyle(
                            color: corSecundaria,
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
                              print("oi");
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