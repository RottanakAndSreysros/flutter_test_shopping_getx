import 'package:get/get.dart';

class CategoryModel extends GetxController {
  final RxInt id;
  final RxString category;
  late RxBool? check;

  CategoryModel({
    required this.id,
    required this.category,
    required this.check,
  });
}

RxList<CategoryModel> listCategory = <CategoryModel>[
  CategoryModel(check: false.obs, id: 1.obs, category: "food".obs),
  CategoryModel(check: false.obs, id: 2.obs, category: "caffee".obs),
  CategoryModel(check: false.obs, id: 3.obs, category: "drink".obs),
].obs;
