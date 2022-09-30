import 'package:get/get.dart';
import 'package:greengrocer/src/constants/storage_keys.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/pages/auth/repository/AuthRepository.dart';
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/pages_routes/app_pages_route.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  final utilsServices = UtilsServices();

  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();
    validateToken();
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    isLoading.value = true;
    final result = await authRepository.changePassword(
      email: user.email!,
      currentPassword: currentPassword,
      newPassword: newPassword,
      token: user.token!,
    );
    isLoading.value = false;
    if (result) {
      utilsServices.showToast(message: 'Senha atualizada com sucesso');
    } else {
      utilsServices.showToast(message: 'Senha atual incorreta', isError: true);
    }
  }

  void saveTokenAndProceedToBase() {
    utilsServices.saveLocalDate(key: StorageKeys.token, value: user.token!);
    Get.offAllNamed(AppPagesRoute.baseRoute);
  }

  Future<void> validateToken() async {
    String? token = await utilsServices.getLocalData(key: StorageKeys.token);

    if (token == null) {
      Get.offAllNamed(AppPagesRoute.signInRoute);
      return;
    }

    AuthResult authResult = await authRepository.validateToken(token);

    authResult.when(success: (user) {
      this.user = user;
      saveTokenAndProceedToBase();
    }, error: (error) {
      signOut();
    });
  }

  Future<void> signOut() async {
    user = UserModel();
    await utilsServices.deleteLocalData(key: StorageKeys.token);
    Get.offAllNamed(AppPagesRoute.signInRoute);
  }

  Future<void> signUp() async {
    isLoading.value = true;
    // await Future.delayed(const Duration(seconds: 2));
    AuthResult authResult = await authRepository.signUp(user);

    authResult.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (error) => utilsServices.showToast(
        message: error,
        isError: true,
      ),
    );

    isLoading.value = false;
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    // await Future.delayed(const Duration(seconds: 2));
    AuthResult authResult =
        await authRepository.signIn(email: email, password: password);

    authResult.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (error) => utilsServices.showToast(
        message: error,
        isError: true,
      ),
    );

    isLoading.value = false;
  }

  Future<void> resetPassword(String email) async {
    await authRepository.resetPassword(email);
  }
}
