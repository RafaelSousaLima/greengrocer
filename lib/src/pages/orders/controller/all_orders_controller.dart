import 'package:get/get.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/orders/orders_result/orders_result.dart';
import 'package:greengrocer/src/pages/orders/repository/orders_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class AllOrdersController extends GetxController {
  List<OrderModel> allOrders = [];
  final OrdersRepository orderRepository = OrdersRepository();
  final AuthController authController = Get.find<AuthController>();
  final UtilsServices utilsServices = UtilsServices();

  @override
  void onInit() {
    super.onInit();
    getAllOrders();
  }

  Future<void> getAllOrders() async {
    OrdersResult<List<OrderModel>> result = await orderRepository.getAllOrders(
        userId: authController.user.id!, token: authController.user.token!);
    result.when(success: (data) {
      allOrders = data
        ..sort((primeiroPedido, segundoPedido) => segundoPedido.createdDateTime!
            .compareTo(primeiroPedido.createdDateTime!));
      update();
    }, error: (message) {
      utilsServices.showToast(message: message);
    });
  }
}
