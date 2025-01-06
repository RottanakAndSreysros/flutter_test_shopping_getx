import 'package:flutter/material.dart';
import 'package:flutter_test_shopping_getx/core/data/controller/product_controller.dart';
import 'package:flutter_test_shopping_getx/core/data/model/product_model.dart';
import 'package:get/get.dart';

final controller = Get.put(ProductController());
Widget cartButtonQuantity(ProductModel product) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      GestureDetector(
        onTap: () {
          controller.incrementQuantity(id: product.id);
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      const SizedBox(width: 10),
      GestureDetector(
        onTap: () {
          controller.decrementQuantity(id: product.id);
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.remove,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}
