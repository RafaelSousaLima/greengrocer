import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/pages/base/controller/navigation_controller.dart';
import 'package:greengrocer/src/pages/cart/cart_tab.dart';
import 'package:greengrocer/src/pages/home/view/home_tab.dart';
import 'package:greengrocer/src/pages/orders/orders_tab.dart';
import 'package:greengrocer/src/pages/profile/profile_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {

  final navigationController = Get.find<NavigationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: navigationController.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          //HOME
          const HomeTab(),
          //CART
          CartTab(),
          //request
          const OrdersTab(),
          //profile
          const ProfileTab(),
        ],
      ),
      bottomNavigationBar: Obx(() =>
          BottomNavigationBar(
            currentIndex: navigationController.currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.green,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withAlpha(100),
            onTap: (index) {
              setState(() {
                navigationController.navigatePageView(index);
                // pageController.animateToPage(
                //     index, duration: const Duration(milliseconds: 100),
                //     curve: Curves.easeInOutQuart);
              });
            },
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home_outlined),
              ),
              BottomNavigationBarItem(
                label: 'Carrinho',
                icon: Icon(Icons.shopping_cart_outlined),
              ),
              BottomNavigationBarItem(
                label: 'Pedidos',
                icon: Icon(Icons.list_outlined),
              ),
              BottomNavigationBarItem(
                label: 'Perfil',
                icon: Icon(Icons.person_outline),
              ),
            ],
          ),),
    );
  }
}
