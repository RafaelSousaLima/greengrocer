import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/auth/components/custom_text_field.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class SignInScreem extends StatelessWidget {
  const SignInScreem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  /*NOME DO APP*/
                  Text.rich(
                    TextSpan(style: const TextStyle(fontSize: 40), children: [
                      const TextSpan(
                        text: 'Green',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'grocer',
                        style: TextStyle(
                          color: CustomColors.customContractColor,
                        ),
                      )
                    ]),
                  ),

                  /*CATEGORIAS*/
                  SizedBox(
                    height: 30,
                    child: DefaultTextStyle(
                      style: const TextStyle(fontSize: 25),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        pause: Duration.zero,
                        animatedTexts: [
                          FadeAnimatedText('Frutas'),
                          FadeAnimatedText('Verduras'),
                          FadeAnimatedText('Legumes'),
                          FadeAnimatedText('Carnes'),
                          FadeAnimatedText('Cereais'),
                          FadeAnimatedText('Laticinios'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ///* FORMULARIO LOGIN */
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(45),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /*EMAIL*/
                  CustomTextField(
                    label: 'E-mail',
                    icon: Icons.email,
                  ),

                  /*SENHA*/
                  CustomTextField(
                    label: 'Senha',
                    icon: Icons.lock,
                    isSecret: true,
                  ),

                  /*ENTRAR*/
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('Entrar'),
                    ),
                  ),

                  /*ESQUECEU A SENHA*/
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Esqueceu a senha?',
                        style: TextStyle(
                          color: CustomColors.customContractColor,
                        ),
                      ),
                    ),
                  ),

                  /*DIVISOR*/
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(children: [
                      Expanded(
                        child: Divider(color: Colors.grey.withAlpha(90)),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text('ou'),
                      ),
                      Expanded(
                        child: Divider(color: Colors.grey.withAlpha(90)),
                      ),
                    ]),
                  ),

                  /*NOVO USUÁRIO*/
                  SizedBox(
                    height: 50,
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          side: const BorderSide(width: 2, color: Colors.green),
                        ),
                        onPressed: () => Navigator.of(context).pushNamed('signIn'),
                        child: const Text(
                          'Criar conta',
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
