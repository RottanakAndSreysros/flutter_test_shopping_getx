import 'package:flutter/widgets.dart';
import 'package:flutter_test_shopping_getx/core/data/model/product_model.dart';
import 'package:flutter_test_shopping_getx/presentation/widget/text_size_20.dart';

Widget cartDetailInformation(ProductModel product) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      textSize16(
        product.name.value,
        fontWeight: FontWeight.w500,
        textOverflow: TextOverflow.ellipsis,
      ),
      textSize16(
        "Price : ${product.price.value}\$",
        fontWeight: FontWeight.w400,
      ),
      textSize16(
        "Off: ${product.discount.value}%",
        fontWeight: FontWeight.w400,
        textOverflow: TextOverflow.ellipsis,
      ),
      textSize16(
        "Quantity : ${product.quantity.value}",
        fontWeight: FontWeight.w400,
      ),
      textSize16(
        "Total : ${product.totalPrice.value.toStringAsFixed(3)} \$",
        fontWeight: FontWeight.w400,
      ),
      textSize16(
        "Payment : ${product.payment.value.toStringAsFixed(3)} \$",
        fontWeight: FontWeight.w400,
      ),
    ],
  );
}
