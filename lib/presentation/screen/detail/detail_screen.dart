import 'package:flutter/material.dart';
import 'package:flutter_test_shopping_getx/core/data/model/product_model.dart';
import 'package:flutter_test_shopping_getx/presentation/screen/home/home_widget/home_product_cart.dart';
import 'package:flutter_test_shopping_getx/presentation/widget/text_size_20.dart';
import 'package:get/get.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({super.key, required this.model});
  ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(model.image.value),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      textSize22(model.name.value, fontWeight: FontWeight.w500),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          textSize20(
                            model.rate.value.toString(),
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                          ),
                          const Icon(Icons.star, color: Colors.amber),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textSize20(
                            "${model.price.value} \$",
                            fontWeight: FontWeight.w500,
                          ),
                          textSize20(
                            "Off  ${model.discount.value} %",
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      textSize18(model.description.value),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            controller.addToCart(model: model);
            print("${model.id.value}");
          },
          child: Container(
            height: 50,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(50),
            ),
            child: textSize24(
              "Add to cart",
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
