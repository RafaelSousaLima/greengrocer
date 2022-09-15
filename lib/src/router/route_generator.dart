import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/auth/sign_in_screen.dart';
import 'package:greengrocer/src/pages/auth/sign_up_screen.dart';
import 'package:greengrocer/src/pages/product/product_screen.dart';
import 'package:greengrocer/src/pages/splash/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (builder) => const SplashScreen());
      case 'signIn': return MaterialPageRoute(builder: (builder) => const SignInScreem());
      case 'signUp': return MaterialPageRoute(builder: (builder) => SignUpScreen());
      case 'productScreen': return MaterialPageRoute(builder: (builder) => ProductScreen(item: args as ItemModel));
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
