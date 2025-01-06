import 'package:flutter_test_shopping_getx/core/data/model/database/item_model.dart';
import 'package:flutter_test_shopping_getx/core/data/model/database/user_model.dart';
import 'package:get/get.dart';

import 'init_database.dart';

class DatabaseController extends GetxController {
  final _init = Get.put(InitDatabase());

  Future<void> insertUser({required UserModel model}) async {
    try {
      final db = await _init.initDatabase();
      await db.insert(_init.tableUser, model.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> insertProduct({required ItemModel model}) async {
    try {
      final db = await _init.initDatabase();
      await db.insert(_init.tableProduct, model.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getUserData() async {
    try {
      final db = await _init.initDatabase();
      List<Map<String, dynamic>> list = await db.query(_init.tableUser);
      return list.map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ItemModel>> getProductData() async {
    try {
      final db = await _init.initDatabase();
      List<Map<String, dynamic>> list = await db.query(_init.tableProduct);
      return list.map((e) => ItemModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserData({required UserModel model}) async {
    try {
      final db = await _init.initDatabase();
      await db.update(
        _init.tableUser,
        model.toJson(),
        where: 'id = ?',
        whereArgs: [model.id?.value],
      );
      print("===========Updated");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProductData({required ItemModel model}) async {
    try {
      final db = await _init.initDatabase();
      await db.update(
        _init.tableProduct,
        model.toJson(),
        where: 'id = ?',
        whereArgs: [model.id?.value],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUserData({required int id}) async {
    try {
      final db = await _init.initDatabase();
      await db.delete(
        _init.tableUser,
        where: 'id = ?',
        whereArgs: [id],
      );
      update();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProductData({required int id}) async {
    try {
      final db = await _init.initDatabase();
      await db.delete(
        _init.tableProduct,
        where: 'id = ?',
        whereArgs: [id],
      );
      update();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserModel>> getAllUserData() async {
    try {
      final List<UserModel> listData = await getUserData();
      update();
      return listData;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ItemModel>> getAllProductData() async {
    try {
      final List<ItemModel> listData = await getProductData();
      update();
      return listData;
    } catch (e) {
      rethrow;
    }
  }
}
