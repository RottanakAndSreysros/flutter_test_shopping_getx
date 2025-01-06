import 'package:get/get.dart';

class UserModel extends GetxController {
  late RxInt? id;
  final RxString name;
  final RxString email;
  final RxString password;
  final RxString? image;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id?.value,
      'name': name.value,
      'email': email.value,
      'password': password.value,
      'image': image?.value,
    };
  }

  // UserModel.fromJson(Map<String, dynamic> map)
  //     : id = RxInt(map['id']),
  //       name = RxString(map['name']),
  //       email = RxString(map['email']),
  //       password = RxString(map['password']),
  //       image = RxString(map['image']);
  UserModel.fromJson(Map<String, dynamic> map)
      : id = map['id'] != null ? RxInt(map['id']) : RxInt(0),
        name = map['name'] != null ? RxString(map['name']) : RxString(''),
        email = map['email'] != null ? RxString(map['email']) : RxString(''),
        password =
            map['password'] != null ? RxString(map['password']) : RxString(''),
        image = map['image'] != null ? RxString(map['image']) : RxString('');
}
