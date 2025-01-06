import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test_shopping_getx/core/data/controller/database/database_controller.dart';
import 'package:flutter_test_shopping_getx/core/data/model/database/item_model.dart';
import 'package:flutter_test_shopping_getx/core/data/model/database/user_model.dart';
import 'package:flutter_test_shopping_getx/presentation/screen/profile/profile_image.dart';
import 'package:flutter_test_shopping_getx/presentation/widget/text_size_20.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'profile_widget/history_cart.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final controller = Get.put(DatabaseController());
  List<UserModel> listModel = <UserModel>[].obs;
  List<ItemModel> listProduct = <ItemModel>[].obs;

  XFile? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? capturedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (capturedFile != null) {
        _image = capturedFile;
        controller.updateUserData(
          model: UserModel(
            id: listModel[0].id,
            name: listModel[0].name,
            email: listModel[0].email,
            password: listModel[0].password,
            image: _image!.path.obs,
          ),
        );
        controller.update();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _pickImageFromCamera() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final XFile? capturedFile =
          await _picker.pickImage(source: ImageSource.camera);

      if (capturedFile != null) {
        _image = capturedFile;
        controller.updateUserData(
          model: UserModel(
            id: listModel[0].id,
            name: listModel[0].name,
            email: listModel[0].email,
            password: listModel[0].password,
            image: _image!.path.obs,
          ),
        );
        controller.update();
      }
    } else {
      print("Permission denied for camera access");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DatabaseController>(
        init: controller,
        initState: (state) async {
          listModel = await controller.getAllUserData();
          listProduct = await controller.getAllProductData();
          controller.update();
        },
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.white,
                  child: Obx(
                    () {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                ProfileImage(
                                    imageUrl: _image == null
                                        ? listModel[0].image!.value
                                        : _image!.path),
                              );
                            },
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: listModel.isNotEmpty &&
                                          _image != null &&
                                          _image!.path.isNotEmpty
                                      ? FileImage(File(_image!.path))
                                      : listModel[0].image!.value ==
                                              "asset/images/profile.jpg"
                                          ? const AssetImage(
                                              "asset/images/profile.jpg")
                                          : listModel.isNotEmpty &&
                                                  _image == null
                                              ? FileImage(File(
                                                  listModel[0].image!.value))
                                              : const AssetImage(
                                                  "asset/images/profile.jpg"),
                                  fit: BoxFit.cover,
                                ),
                                border:
                                    Border.all(width: 2, color: Colors.grey),
                              ),
                            ),
                          ),
                          textSize20(
                            listModel.isNotEmpty
                                ? listModel[0].name.value
                                : 'No user data',
                            fontWeight: FontWeight.w700,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.dialog(
                                    profileDialog(),
                                  );
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.edit),
                                    textSize18("Edit",
                                        fontWeight: FontWeight.w500),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textSize22("Your history", fontWeight: FontWeight.w900),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: listProduct.isEmpty
                      ? Center(
                          child: textSize22(
                          "Empty",
                          fontWeight: FontWeight.w900,
                          color: Colors.purple,
                        ))
                      : ListView.builder(
                          itemCount: listProduct.length,
                          itemBuilder: (context, index) {
                            final item = listProduct[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: historyCart(item),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Profile picture dialog with options for selecting from gallery
  Center profileDialog() {
    return Center(
      child: Container(
        height: 150,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Do you want to change your profile?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: textSize18(
                      "Close",
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.bottomSheet(
                        openBottomSheet(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: textSize18(
                      "Ok",
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container openBottomSheet() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  _pickImageFromCamera();
                  Get.back();
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.camera_alt),
                      const SizedBox(width: 8),
                      textSize18(
                        "Camera",
                        fontWeight: FontWeight.w900,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  _pickImageFromGallery();
                  Get.back();
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.photo_library),
                      const SizedBox(width: 8),
                      textSize18(
                        "Gallery",
                        fontWeight: FontWeight.w900,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
