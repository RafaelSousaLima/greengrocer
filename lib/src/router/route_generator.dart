import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/pages/auth/sign_in_screen.dart';
import 'package:greengrocer/src/pages/auth/sign_up_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (builder) => const SignInScreem());
      case 'signIn': return MaterialPageRoute(builder: (builder) => SignUpScreen());
    }
    return _erroRoute();
  }

  static Route<dynamic> _erroRoute() {
    return MaterialPageRoute(builder: (builder) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.customContractColor,
        ),
        body: const Center(
          child: Text('ERROR, rota não encontrada'),
        ),
      );
    });
  }
}
