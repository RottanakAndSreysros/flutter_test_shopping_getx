import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class InitDatabase extends GetxController {
  final String tableUser = "user";
  final String tableProduct = "product";

  Future<Database> initDatabase() async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String path = "${directory.path}/etecdatabase.db";

      return await openDatabase(
        path,
        version: 1,
        onOpen: (db) {},
        onCreate: (db, version) async {
          await _oncreateDatabase(db.batch());
        },
        onUpgrade: (db, oldVersion, newVersion) {},
      );
    } catch (e) {
      // ignore: avoid_print
      print(
          "====================================Error initializing database: $e");
      rethrow;
    }
  }

  Future<void> _oncreateDatabase(Batch batch) async {
    batch.execute(
        "CREATE TABLE $tableUser (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,name TEXT,email TEXT,password TEXT,image TEXT);");
    batch.execute(
        "CREATE TABLE $tableProduct (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,name TEXT,payment REAL,price REAL, quantity INTEGER,discount REAL, image TEXT,date TEXT);");
    await batch.commit();
  }
}
