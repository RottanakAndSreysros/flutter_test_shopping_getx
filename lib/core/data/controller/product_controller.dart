import 'package:flutter/material.dart';
import 'package:flutter_test_shopping_getx/core/data/model/product_model.dart';
import 'package:get/get.dart';

RxList<ProductModel> listCart = <ProductModel>[].obs;

class ProductController extends GetxController {
  final RxDouble total = 0.0.obs;
  final RxDouble payment = 0.0.obs;
  Future<void> addToCart({required ProductModel model}) async {
    try {
      if (!listCart.any((element) => element.id == model.id)) {
        final RxDouble totalPayment =
            (model.price.value - (model.discount * model.price.value) / 100)
                .obs;
        final RxDouble totalPrice = model.price.value.obs;
        listCart.add(
          ProductModel(
            id: model.id,
            name: model.name,
            price: model.price,
            image: model.image,
            description: model.description,
            rate: model.rate,
            discount: model.discount,
            quantity: model.quantity,
            totalPrice: totalPrice,
            payment: totalPayment,
            category: model.category,
            check: model.check,
          ),
        );
        changePayment();
        Get.snackbar(
          "Successful!",
          "Added to cart successfully.",
          duration: const Duration(milliseconds: 800),
        );
      } else {
        Get.snackbar(
          icon: Image.asset("asset/animations/happy.gif"),
          "Hello!",
          "This product is already in the cart.",
          duration: const Duration(milliseconds: 800),
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print("==============$e}");
      rethrow;
    }
  }

  Future<void> deleteFromCart({required RxInt id}) async {
    listCart.removeWhere((element) => element.id == id);
    Get.snackbar("Successful!", "Removed from cart successfully.");
  }

  Future<void> incrementQuantity({required RxInt id}) async {
    final product = listCart.firstWhere((element) => element.id == id);
    if (product.quantity >= 1) {
      product.quantity++;
      updateProductCart(product);
    }
    changePayment();
    update();
  }

  void decrementQuantity({required RxInt id}) {
    final product = listCart.firstWhere((product) => product.id == id);
    if (product.quantity > 1) {
      product.quantity--;
      updateProductCart(product);
    }
    changePayment();
    update();
  }

  Future<void> changePayment() async {
    total.value = 0.0;
    payment.value = 0.0;
    for (int i = 0; i < listCart.length; i++) {
      total.value += listCart[i].totalPrice.value;
      payment.value += listCart[i].payment.value;
    }
  }

  void updateProductCart(ProductModel product) {
    product.totalPrice.value = (product.price.value * product.quantity.value);
    product.payment.value = product.totalPrice.value -
        (product.totalPrice.value * product.discount.value / 100);
    update();
  }

  Future<void> onClickFavorite(ProductModel model) async {
    if (!listFavorite.any((element) => element.id == model.id)) {
      listFavorite.add(model);
      Get.snackbar(
        "Successful!",
        "Add to favorite successfully!",
        duration: const Duration(milliseconds: 800),
      );
    } else {
      listFavorite.removeWhere((element) => element.id == model.id);
      Get.snackbar(
        icon: Image.asset("asset/animations/happy.gif"),
        "Hello!",
        "Remove from favorite successfully!",
        duration: const Duration(milliseconds: 800),
      );
    }
    checkFavorite();
    update();
  }

  Future<void> checkFavorite() async {
    for (int i = 0; i < listItem.length; i++) {
      listItem[i].check.value = false;
      for (int j = 0; j < listFavorite.length; j++) {
        if (listItem[i].id.value == listFavorite[j].id.value) {
          listItem[i].check.value = true;
        }
      }
    }
    update();
  }
}
