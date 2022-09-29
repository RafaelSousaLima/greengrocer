import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/cart/cart_result/cart_result.dart';
import 'package:greengrocer/src/pages/cart/repository/CartRepository.dart';
import 'package:greengrocer/src/pages/common_widgets/paymento_dialog.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class CartController extends GetxController {
  final CartRepository _cartRepository = CartRepository();
  final AuthController _authController = Get.find<AuthController>();
  final UtilsServices _utilsServices = UtilsServices();

  List<CartItemModel> cartItens = [];

  bool isCheckoutLoading = false;

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  double getTotalPrice() {
    double total = 0;
    for (final item in cartItens) {
      total += item.totalPrice();
    }
    return total;
  }

  Future checkoutCart() async {
    setCheckoutLoading(true);

    CartResult<OrderModel> cartResult = await _cartRepository.checkoutCart(
      token: _authController.user.token!,
      total: getTotalPrice(),
    );

    setCheckoutLoading(false);


    cartResult.when(
        success: (data) {
          cartItens.clear();
          update();
          showDialog(
            context: Get.context!,
            builder: (_) => PaymentDialog(
              order: data,
            ),
          );
        },
        error: (message) {
          _utilsServices.showToast(message: message);
        });
  }

  void setCheckoutLoading(bool value) {
    isCheckoutLoading = value;
    update();
  }

  Future<bool> changeItemQuantity({
    required CartItemModel cartItemModel,
    required int quantity,
  }) async {
    final result = await _cartRepository.chageItemQuantity(
        token: _authController.user.token!,
        cartItemId: cartItemModel.id,
        quantity: quantity);

    if (result) {
      if (quantity == 0) {
        cartItens.removeWhere((cartItem) => cartItem.id == cartItemModel.id);
      } else {
        cartItens
            .firstWhere((cartItem) => cartItem.id == cartItemModel.id)
            .quantity = quantity;
      }
      update();
    }

    return result;
  }

  Future<void> getCartItems() async {
    CartResult<List<CartItemModel>> cartResult =
        await _cartRepository.getCartItems(
      token: _authController.user.token!,
      userId: _authController.user.id!,
    );

    cartResult.when(success: (data) {
      cartItens = data;
      update();
    }, error: (message) {
      _utilsServices.showToast(message: message, isError: true);
    });
  }

  int getItemIndex(ItemModel item) {
    return cartItens.indexWhere((itemList) => itemList.item.id == item.id);
  }

  Future addItemToCart({required ItemModel item, int quantity = 1}) async {
    int itemIndex = getItemIndex(item);
    if (itemIndex >= 0) {
      final product = cartItens[itemIndex];

      final result = await changeItemQuantity(
        cartItemModel: product,
        quantity: (product.quantity + quantity),
      );

      if (result) {
        // cartItens[itemIndex].quantity += quantity;
      } else {
        _utilsServices.showToast(
            message: 'Ocorreu um erro ao adicionar a quantidade do produto',
            isError: true);
      }
    } else {
      UserModel user = _authController.user;
      final CartResult<String> result = await _cartRepository.addItemToCart(
        userId: user.id!,
        token: user.token!,
        productId: item.id,
        quantity: quantity,
      );
      result.when(success: (data) {
        cartItens.add(CartItemModel(id: '', item: item, quantity: quantity));
      }, error: (message) {
        _utilsServices.showToast(message: message, isError: true);
      });
    }
    update();
  }
}
