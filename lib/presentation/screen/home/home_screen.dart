import 'package:flutter/material.dart';
import 'package:flutter_test_shopping_getx/core/data/controller/check_category.dart';
import 'package:flutter_test_shopping_getx/core/data/controller/product_controller.dart';
import 'package:flutter_test_shopping_getx/core/data/model/category_model.dart';
import 'package:flutter_test_shopping_getx/core/data/model/product_model.dart';
import 'package:flutter_test_shopping_getx/presentation/screen/detail/detail_screen.dart';
import 'package:flutter_test_shopping_getx/presentation/screen/home/home_widget/HomeSlider_widget.dart';
import 'package:flutter_test_shopping_getx/presentation/widget/text_size_20.dart';
import 'package:get/get.dart';
import 'home_widget/home_product_cart.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put(ProductController());
  final _searchController = TextEditingController();
  final RxList<ProductModel> listSearch = <ProductModel>[].obs;

  Future<void> search(String query) async {
    listSearch.clear();
    listSearch.value = listSlide
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: CheckCategory(),
        initState: (state) {
          if (listItem.isEmpty) {
            CheckCategory().onClickCategory(1);
            controller.checkFavorite();
            list1.value = List.from(listFood);
            list2.value = List.from(listDrink);
            list3.value = List.from(listCoffee);
            listSlide.value = (list1 + list2 + list3);
          }
        },
        builder: (controller) {
          return Column(
            children: [
              const SizedBox(height: 25),
              homeSliderWidget(listSlide),
              //Search
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      search(value);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              //Category
              SizedBox(
                height: 50,
                width: 400,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listCategory.length,
                  itemBuilder: (context, index) {
                    final category = listCategory[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () async {
                          CheckCategory().onClickCategory(category.id.value);
                          listSearch.clear();
                        },
                        child: Obx(
                          () {
                            return Container(
                              height: 50,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: category.check!.value
                                    ? Colors.blue
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: textSize16(
                                category.category.value,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              // Product List
              Expanded(
                child: Obx(
                  () {
                    return listItem.isEmpty
                        ? const Center(
                            child:
                                Text("No products available in this category"),
                          )
                        : ListView.builder(
                            itemCount: listSearch.isNotEmpty
                                ? listSearch.length
                                : listItem.length,
                            itemBuilder: (context, index) {
                              final product = listSearch.isNotEmpty
                                  ? listSearch[index]
                                  : listItem[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(DetailScreen(model: product));
                                  },
                                  child: productCart(product),
                                ),
                              );
                            },
                          );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
