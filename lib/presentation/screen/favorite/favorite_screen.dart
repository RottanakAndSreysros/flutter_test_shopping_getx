import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_test_shopping_getx/core/data/controller/product_controller.dart';
import 'package:flutter_test_shopping_getx/core/data/model/product_model.dart';
import 'package:flutter_test_shopping_getx/presentation/screen/cart/cart_widget/cart_detail_information.dart';
import 'package:flutter_test_shopping_getx/presentation/screen/cart/cart_widget/cart_image.dart';
import 'package:flutter_test_shopping_getx/presentation/screen/detail/detail_screen.dart';
import 'package:flutter_test_shopping_getx/presentation/widget/text_size_20.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});
  final controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(null),
        centerTitle: true,
        title: textSize20("Your Favorite", fontWeight: FontWeight.w500),
      ),
      body: GetBuilder(
        init: controller,
        builder: (controller) {
          return listFavorite.isEmpty
              ? const Center(
                  child: Text("Empty"),
                )
              : CustomScrollView(
                  slivers: [
                    Obx(
                      () {
                        return SliverList.builder(
                          itemCount: listFavorite.length,
                          itemBuilder: (context, index) {
                            final product = listFavorite[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Slidable(
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      flex: 2,
                                      onPressed: (context) {
                                        controller.onClickFavorite(product);
                                      },
                                      borderRadius: BorderRadius.circular(10),
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: Card(
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          bottom: 10,
                                          top: 10,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(
                                              DetailScreen(model: product),
                                            );
                                          },
                                          child: cartImage(product),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: cartDetailInformation(
                                                    product),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
        },
      ),
    );
  }
}
