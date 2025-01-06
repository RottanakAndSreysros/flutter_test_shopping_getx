import 'package:get/get.dart';

class ItemModel extends GetxController {
  late RxInt? id;
  final RxString name;
  final RxDouble payment;
  final RxDouble price;
  final RxInt quantity;
  final RxDouble discount;
  final RxString image;
  final RxString date;

  ItemModel({
    this.id,
    required this.name,
    required this.payment,
    required this.price,
    required this.quantity,
    required this.discount,
    required this.image,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id?.value,
      'name': name.value,
      'payment': payment.value,
      'price': price.value,
      'quantity': quantity.value,
      'discount': discount.value,
      'image': image.value,
      'date': date.value,
    };
  }

  ItemModel.fromJson(Map<String, dynamic> map)
      : id = RxInt(map['id']),
        name = RxString(map['name']),
        payment = RxDouble(map['payment']),
        price = RxDouble(map['price']),
        quantity = RxInt(map['quantity']),
        discount = RxDouble(map['discount']),
        image = RxString(map['image']),
        date = RxString(map['date']);
}
