import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/orders/orders_result/orders_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';
import 'package:greengrocer/src/services/http_methods.dart';

class OrdersRepository {
  final HttpManager _httpManager = HttpManager();

  Future<OrdersResult<List<CartItemModel>>> getOrderItems(
      {required String orderId, required String token}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getOrderItems,
      method: HttpMethods.post,
      boby: {
        'orderId': orderId,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );
    if (result['result'] != null) {
      return OrdersResult<List<CartItemModel>>.success(
          List<Map<String, dynamic>>.from(result['result'])
              .map((cartItemModel) => CartItemModel.fromJson(cartItemModel))
              .toList());
    } else {
      return OrdersResult.error('Não foi possivel recuperar o itens do pedido');
    }
  }

  Future<OrdersResult<List<OrderModel>>> getAllOrders(
      {required String userId, required String token}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllOrders,
      method: HttpMethods.post,
      boby: {
        'user': userId,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      return OrdersResult<List<OrderModel>>.success(
          List<Map<String, dynamic>>.from(result['result'])
              .map(OrderModel.fromJson)
              .toList());
    } else {
      return OrdersResult.error('Não foi possível recuperar os pedidos');
    }
  }
}
