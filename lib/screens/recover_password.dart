import 'package:flutter/material.dart';
import 'package:mauanews/components/button_widget.dart';
import 'package:mauanews/components/text_field.dart';
import 'package:mauanews/services/auth_service.dart';
import 'package:mauanews/utils/colors.dart';

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

                  const SizedBox(height: 55),

                  const Icon(Icons.lock_outlined, size: 170, color: Colors.grey,),

                  const SizedBox(height: 30),
                  
                  const Text(
                    'Recupere a sua senha',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                    "Por favor, informe seu endereço de e-mail",
                    style: TextStyle(
                      color: secondTextColor,
                      fontSize: 19,
                      ),
                    ),
                    const Text(
                    "associado a sua conta para que possamos",
                    style: TextStyle(
                      color: secondTextColor,
                      fontSize: 19,
                      ),
                    ),
                    const Text(
                    "enviar um link de redefinição",
                    style: TextStyle(
                      color: secondTextColor,
                      fontSize: 19,
                      ),
                    ),
                    const SizedBox(height: 30),

                    MyTextField(
                      controller: emailController,
                      hintText: "Digite seu email",
                      icon: const Icon(Icons.email_outlined, size: 20, color: Colors.grey,), 
                    ),

                    const SizedBox(height: 25),

                    ButtonWidget(
                      text: "Enviar",
                      onTap: (){
                        final recuperarSenha=googleSignProv();
                        recuperarSenha.resetPassword(context, emailController.text);
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