import 'package:flutter/material.dart';
import 'package:flutter_test_shopping_getx/core/data/model/product_model.dart';

Widget cartImage(ProductModel model) {
  return Container(
    height: 190,
    width: 180,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
        image: AssetImage(
          model.image.value,
        ),
        fit: BoxFit.cover,
      ),
    ),
  );
}
