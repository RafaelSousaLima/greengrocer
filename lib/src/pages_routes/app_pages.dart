import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/view/sign_in_screen.dart';
import 'package:greengrocer/src/pages/auth/view/sign_up_screen.dart';
import 'package:greengrocer/src/pages/base/base_screen.dart';
import 'package:greengrocer/src/pages/home/binding/home_binding.dart';
import 'package:greengrocer/src/pages/splash/splash_screen.dart';
import 'package:greengrocer/src/pages_routes/app_pages_route.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppPagesRoute.splashRoute,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppPagesRoute.signInRoute,
      page: () => SignInScreem(),
    ),
    GetPage(
      name: AppPagesRoute.signUpRoute,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: AppPagesRoute.baseRoute,
      page: () => BaseScreen(),
      bindings: [
        HomeBinding(),
      ],
    ),
  ];
}
