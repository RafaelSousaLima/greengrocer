import 'package:get/get.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/orders/orders_result/orders_result.dart';
import 'package:greengrocer/src/pages/orders/repository/orders_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class OrderController extends GetxController {
  final OrderModel order;

  OrderController(this.order);

  final OrdersRepository ordersRepository = OrdersRepository();
  final AuthController authController = Get.find<AuthController>();
  final UtilsServices utilsServices = UtilsServices();
  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> getOrderItems() async {
    final OrdersResult<List<CartItemModel>> result = await
        ordersRepository.getOrderItems(
            orderId: order.id, token: authController.user.token!);


    result.when(
        success: (data) {
          order.items = data;
          update();
        },
        error: (message) {
          utilsServices.showToast(message: message, isError: true);
        });
  }
}
