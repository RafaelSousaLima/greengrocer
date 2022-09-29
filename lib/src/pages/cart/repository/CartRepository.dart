import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/cart/cart_result/cart_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';
import 'package:greengrocer/src/services/http_methods.dart';

class CartRepository {
  final HttpManager _httpManager = HttpManager();

  Future<CartResult<List<CartItemModel>>> getCartItems({
    required String token,
    required String userId,
  }) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.getCartItems,
        method: HttpMethods.post,
        headers: {
          'X-Parse-Session-Token': token,
        },
        boby: {
          'user': userId,
        });
    if (result['result'] != null) {
      List<CartItemModel> data =
          List<Map<String, dynamic>>.from(result['result'])
              .map((cart) => CartItemModel.fromJson(cart))
              .toList();
      return CartResult.success(data);
    } else {
      return CartResult.error('Erro ao retornar os itens do carrinho.');
    }
  }

  Future<CartResult<OrderModel>> checkoutCart({
    required String token,
    required double total,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.checkout,
      method: HttpMethods.post,
      boby: {'total': total},
      headers: {
        'X-Parse-Session-Token': token,
      },
    );
    if (result['result'] != null) {
      return CartResult<OrderModel>.success(OrderModel.fromJson(result['result']));
    } else {
      return CartResult.error('Não foi possivel realizar o pedido');
    }
  }

  Future<bool> chageItemQuantity({
    required String token,
    required String cartItemId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.changeCartQuantity,
      method: HttpMethods.post,
      boby: {
        'cartItemId': cartItemId,
        'quantity': quantity,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    return result.isEmpty;
  }

  Future<CartResult<String>> addItemToCart({
    required String userId,
    required String token,
    required String productId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.addItemToCart,
      method: HttpMethods.post,
      boby: {
        'user': userId,
        'quantity': quantity,
        'productId': productId,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );
    if (result['result'] != null) {
      //  Sucesso
      return CartResult<String>.success(result['result']['id']);
    } else {
      //  Falha
      return CartResult.error('Não foi possivel adicionar o item ao carrinho.');
    }
  }
}
