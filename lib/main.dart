import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_shopping_getx/core/data/model/database/user_model.dart';
import 'package:flutter_test_shopping_getx/presentation/screen/login/login_screen.dart';
import 'package:flutter_test_shopping_getx/presentation/screen/register/register_screen.dart';
import 'package:get/get.dart';

import 'core/data/controller/database/database_controller.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  final controller = Get.put(DatabaseController());
  List<UserModel> listModel = <UserModel>[].obs;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: GetBuilder<DatabaseController>(
        init: controller,
        initState: (state) async {
          listModel = await controller.getAllUserData();
        },
        builder: (controller) {
          return listModel.isEmpty
              ? const RegisterScreen()
              : const LoginScreen();
        },
      ),
    );
  }
}
