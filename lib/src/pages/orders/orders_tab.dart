import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/app_data.dart' as data;
import 'package:greengrocer/src/pages/orders/components/Order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (_, index) => const SizedBox(
          height: 10,
        ),
        itemBuilder: (_, index) => OrderTile(order: data.orders[index]),
        itemCount: data.orders.length,
      ),
    );
  }
}
