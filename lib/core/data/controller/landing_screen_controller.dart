import 'package:flutter/material.dart';
import 'package:flutter_test_shopping_getx/presentation/screen/cart/cart_screen.dart';
import 'package:flutter_test_shopping_getx/presentation/screen/favorite/favorite_screen.dart';
import 'package:flutter_test_shopping_getx/presentation/screen/home/home_screen.dart';
import 'package:flutter_test_shopping_getx/presentation/screen/profile/profile_screen.dart';
import 'package:get/get.dart';

class LandingScreenController extends GetxController {
  RxList<Widget> listScreen = <Widget>[
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen(),
  ].obs;
}
