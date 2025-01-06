import 'package:flutter_test_shopping_getx/core/data/model/category_model.dart';
import 'package:flutter_test_shopping_getx/core/data/model/product_model.dart';
import 'package:get/get.dart';

class CheckCategory extends GetxController {
  Future<void> onClickCategory(int id) async {
    final RxInt index = (id - 1).obs;

    for (RxInt i = 0.obs; i < listCategory.length; i++) {
      if (i == index.value) {
        listCategory[i.value].check?.value = true;
      } else {
        listCategory[i.value].check?.value = false;
      }
    }
    await checkProduct().then((value) => update());
  }

  Future<void> checkProduct() async {
    listItem.clear();
    for (int i = 0; i < listCategory.length; i++) {
      if (listCategory[i].check?.value == true) {
        if (i == 0) {
          listItem.value = List.from(listFood);
        } else if (i == 1) {
          listItem.value = List.from(listCoffee);
        } else if (i == 2) {
          listItem.value = List.from(listDrink);
        }
        break;
      }
    }
  }
}
