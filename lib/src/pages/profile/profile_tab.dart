import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/common_widgets/custom_text_field.dart';
import 'package:greengrocer/src/services/validators.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil do usuário"),
        actions: [
          IconButton(
            onPressed: () => authController.signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          //EMAIL
          CustomTextField(
            readOnly: true,
            icon: Icons.email,
            label: 'E-mail',
            initialValue: authController.user.email,
          ),

          //NOME
          CustomTextField(
            readOnly: true,
            icon: Icons.person,
            label: 'Nome',
            initialValue: authController.user.name,
          ),

          //CELULAR
          CustomTextField(
            readOnly: true,
            icon: Icons.phone,
            label: 'Celular',
            initialValue: authController.user.phone,
          ),

          //CPF
          CustomTextField(
            readOnly: true,
            icon: Icons.file_copy,
            label: 'CPF',
            initialValue: authController.user.cpf,
            isSecret: true,
          ),

          //  Botão de atualizar senha
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.green,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () => updatePassword(),
              child: const Text('Atualizar Senha'),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController newPasswordController =
        TextEditingController();
    final TextEditingController currentPasswordController =
        TextEditingController();
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              //Padding do conteudo
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //Titulo
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Atualizar senha',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      //Senha atual
                      CustomTextField(
                        icon: Icons.lock,
                        label: 'Senha atual',
                        isSecret: true,
                        controller: currentPasswordController,
                        validator: passwordValidator,
                      ),

                      //Nova senha
                      CustomTextField(
                        icon: Icons.lock_outline,
                        label: 'Nova senha',
                        isSecret: true,
                        controller: newPasswordController,
                        validator: passwordValidator,
                      ),

                      //Confirmar senha
                      CustomTextField(
                        icon: Icons.lock_outline,
                        label: 'Confirmar nova senha',
                        isSecret: true,
                        validator: (password) {
                          final result = passwordValidator(password);
                          if (result != null) {
                            return result;
                          }
                          if (password != newPasswordController.text) {
                            return 'Senhas não são iguais';
                          }
                        },
                      ),

                      //Botão de atualizar senha
                      SizedBox(
                        height: 45,
                        child: Obx(
                          () => ElevatedButton(
                            onPressed: authController.isLoading.value
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      authController.changePassword(
                                          currentPassword: currentPasswordController.text,
                                          newPassword: newPasswordController.text);
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: authController.isLoading.value
                                ? const CircularProgressIndicator()
                                : const Text('Atualizar'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Botão de fechar o dialog
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
