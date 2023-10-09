import 'package:flutter/material.dart';
import 'package:mauanews/components/button_widget.dart';
import 'package:mauanews/components/imagens_login.dart';
import 'package:mauanews/components/text_field.dart';
import 'package:mauanews/utils/colors.dart';
import 'feed.dart';

class RecoverPassword extends StatelessWidget {
  RecoverPassword({super.key});
  
  final emailController = TextEditingController();

  void login(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: (
        
      // ),
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
                  
                  const Text(
                    'Recupere a sua senha',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                    "Por favor, informe seu endereço de e-mail",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      ),
                    ),
                    const Text(
                    "associado a sua conta para que possamos",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      ),
                    ),
                    const Text(
                    "enviar um link de redefinição",
                    style: TextStyle(
                      color: Colors.grey,
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

                    ButtonWidget(
                      text: "Enviar",
                      onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RecoverPassword()),
                        );
                      },
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