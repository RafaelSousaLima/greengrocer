import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.customContractColor,
      body: Column(
        children: const [
          Text(
            "Cadastro",
            style: TextStyle(color: Colors.white, fontSize: 25),
          )
        ],
      ),
    );
  }
}
