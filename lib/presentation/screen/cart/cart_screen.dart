import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_test_shopping_getx/core/data/controller/database/database_controller.dart';
import 'package:flutter_test_shopping_getx/core/data/controller/product_controller.dart';
import 'package:flutter_test_shopping_getx/core/data/model/database/item_model.dart';
import 'package:flutter_test_shopping_getx/presentation/screen/cart/cart_widget/cart_button_quantity.dart';
import 'package:flutter_test_shopping_getx/presentation/screen/cart/cart_widget/cart_detail_information.dart';
import 'package:flutter_test_shopping_getx/presentation/screen/cart/cart_widget/cart_image.dart';
import 'package:flutter_test_shopping_getx/presentation/screen/detail/detail_screen.dart';
import 'package:flutter_test_shopping_getx/presentation/widget/snackbar_widget.dart';
import 'package:flutter_test_shopping_getx/presentation/widget/text_size_20.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final controller = Get.put(ProductController());
  final databaseController = Get.put(DatabaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(null),
        centerTitle: true,
        title: textSize20("Your Cart", fontWeight: FontWeight.w500),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: GetBuilder(
            init: controller,
            initState: (state) {
              controller.changePayment();
            },
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Obx(
                  () {
                    return Row(
                      children: [
                        textSize20("Total : ", fontWeight: FontWeight.w800),
                        textSize24(
                          "\$ ${controller.payment.value.toStringAsFixed(3)}",
                          fontWeight: FontWeight.w900,
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
      body: GetBuilder(
        init: controller,
        initState: (state) {
          controller.changePayment();
        },
        builder: (controller) {
          return listCart.isEmpty
              ? const Center(
                  child: Text("Empty"),
                )
              : CustomScrollView(
                  slivers: [
                    Obx(
                      () {
                        return SliverList.builder(
                          itemCount: listCart.length,
                          itemBuilder: (context, index) {
                            final product = listCart[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Slidable(
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      flex: 2,
                                      onPressed: (context) {
                                        controller.deleteFromCart(
                                            id: product.id);
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
                                          height: 210,
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
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 8.0,
                                                  bottom: 8.0,
                                                ),
                                                child:
                                                    cartButtonQuantity(product),
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
      bottomNavigationBar: listCart.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  for (int i = 0; i < listCart.length; i++) {
                    final name = listCart[i].name.value;
                    final payment = listCart[i].payment.value;
                    final price = listCart[i].price.value;
                    final quantity = listCart[i].quantity.value;
                    final image = listCart[i].image.value;
                    final discount = listCart[i].discount.value;
                    final date = DateTime.now();
                    // ignore: no_leading_underscores_for_local_identifiers
                    final String _time =
                        "${date.day}/${date.month}/${date.year}";
                    databaseController.insertProduct(
                      model: ItemModel(
                        name: name.obs,
                        payment: payment.obs,
                        price: price.obs,
                        quantity: quantity.obs,
                        discount: discount.obs,
                        image: image.obs,
                        date: _time.obs,
                      ),
                    );
                  }
                  snackbarWidget(
                    image: "asset/animations/delevery.gif",
                    title: "Successful!",
                    subtitle: "Your check out completed successfully!",
                  );
                  Future.delayed(const Duration(milliseconds: 500)).then(
                    (value) {
                      listCart.clear();
                      controller.changePayment();
                    },
                  );
                },
                child: Container(
                  height: 55,
                  width: 130,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: textSize22(
                    "Checkout",
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
    );
  }
}
