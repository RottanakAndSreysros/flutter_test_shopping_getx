import 'package:flutter/material.dart';
import 'package:flutter_test_shopping_getx/core/data/controller/landing_screen_controller.dart';
import 'package:flutter_test_shopping_getx/core/data/controller/product_controller.dart';
import 'package:flutter_test_shopping_getx/presentation/widget/text_size_20.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

class LandingScreen extends StatelessWidget {
  LandingScreen({super.key});
  final RxInt _selectedIndex = 0.obs;
  final landingScreenController = Get.put(LandingScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return landingScreenController.listScreen[_selectedIndex.value];
        },
      ),
      bottomNavigationBar: Obx(
        () {
          return BottomNavigationBar(
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Favorite",
              ),
              BottomNavigationBarItem(
                icon: badges.Badge(
                  badgeContent: textSize14(
                    "${listCart.length}",
                    color: Colors.white,
                  ),
                  child: const Icon(Icons.shopping_cart),
                ),
                label: "Cart",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black,
            currentIndex: _selectedIndex.value,
            onTap: (value) {
              _selectedIndex.value = value;
            },
          );
        },
      ),
    );
  }
}
