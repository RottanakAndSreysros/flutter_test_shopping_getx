import 'package:flutter/material.dart';
import 'package:flutter_test_shopping_getx/core/data/controller/product_controller.dart';
import 'package:flutter_test_shopping_getx/core/data/model/product_model.dart';
import 'package:flutter_test_shopping_getx/presentation/widget/text_size_20.dart';
import 'package:get/get.dart';

final controller = Get.put(ProductController());

Widget productCart(ProductModel product) {
  return Container(
    height: 250,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.amber,
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
        image: AssetImage(product.image.value),
        fit: BoxFit.cover,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        width: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              textSize16(product.rate.toString(),
                                  color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          final payment = product.price.value -
                              (product.discount.value * product.price.value) /
                                  100;
                          await controller.onClickFavorite(ProductModel(
                              id: product.id,
                              name: product.name,
                              price: product.price,
                              image: product.image,
                              description: product.description,
                              rate: product.rate,
                              discount: product.discount,
                              quantity: product.quantity,
                              totalPrice: product.price,
                              payment: payment.obs,
                              category: product.category,
                              check: product.check));
                          print("====================");
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.amber,
                            shape: BoxShape.circle,
                          ),
                          child: product.check.value
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(Icons.favorite_border),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              width: 150,
              height: 100,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Positioned(
                    top: -30,
                    right: -60,
                    child: Container(
                      alignment: Alignment.center,
                      height: 35,
                      width: 150,
                      color: Colors.red,
                      transform: Matrix4.rotationZ(0.7),
                      child: textSize18(
                        "Off ${product.discount} %",
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        //textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Container(
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: textSize16(
                    product.name.toString(),
                    color: Colors.white,
                    textOverflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        controller.addToCart(model: product);
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: textSize16(
                          "Add to cart",
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
