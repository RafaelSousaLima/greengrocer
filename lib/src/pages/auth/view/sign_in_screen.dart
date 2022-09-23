import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/auth/view/components/forgot_password_dialog.dart';
import 'package:greengrocer/src/pages/common_widgets/custom_text_field.dart';
import 'package:greengrocer/src/pages/base/base_screen.dart';
import 'package:greengrocer/src/pages/common_widgets/app_name_widget.dart';
import 'package:greengrocer/src/pages_routes/app_pages_route.dart';
import 'package:greengrocer/src/services/utils_services.dart';
import 'package:greengrocer/src/services/validators.dart';

class SignInScreem extends StatelessWidget {
  SignInScreem({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;

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
                  const AppNameWidget(
                    greenTitleColor: Colors.white,
                    textSize: 40,
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /*EMAIL*/
                    CustomTextField(
                        label: 'E-mail',
                        icon: Icons.email,
                        controller: emailController,
                        validator: emailValidator
                    ),

                    /*SENHA*/
                    CustomTextField(
                        label: 'Senha',
                        icon: Icons.lock,
                        isSecret: true,
                        controller: passwordController,
                        validator: passwordValidator
                    ),

                    /*ENTRAR*/
                    SizedBox(
                      height: 50,
                      child: GetX<AuthController>(builder: (authController) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          onPressed: authController.isLoading.value
                              ? null
                              : () {
                            // Get.offNamed(AppPagesRoute.baseRoute);
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              String email = emailController.text;
                              String pass = passwordController.text;
                              authController.signIn(
                                  email: email, password: pass);
                            } else {}
                          },
                          child: authController.isLoading.value
                              ? const CircularProgressIndicator()
                              : const Text('Entrar'),
                        );
                      }),
                    ),

                    /*ESQUECEU A SENHA*/
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () async {
                          final result = await showDialog(
                              context: context, builder: (build) {
                            return ForgotPasswordDialog(
                                email: emailController.text);
                          });
                          if (result ?? false) {
                            utilsServices.showToast(
                                message: 'Um link de e-mail foi enviado para seu e-mail.');
                          }
                        },
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
                            side:
                            const BorderSide(width: 2, color: Colors.green),
                          ),
                          onPressed: () =>
                              Get.toNamed(AppPagesRoute.signUpRoute),
                          child: const Text(
                            'Criar conta',
                            style: TextStyle(fontSize: 18),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
