import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/pages/orders/controller/all_orders_controller.dart';
import 'package:greengrocer/src/pages/orders/view/components/Order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: GetBuilder<AllOrdersController>(
        builder: (controller) {
          if (controller.allOrders.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.remove_shopping_cart,
                  size: 40,
                  color: CustomColors.customSwatchColor,
                ),
                const Text(
                  'Nao ha pedidos',
                  textAlign: TextAlign.center,
                ),
              ],
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (_, index) => const SizedBox(
              height: 10,
            ),
            itemBuilder: (_, index) =>
                OrderTile(order: controller.allOrders[index]),
            itemCount: controller.allOrders.length,
          );
        },
      ),
    );
  }
}
