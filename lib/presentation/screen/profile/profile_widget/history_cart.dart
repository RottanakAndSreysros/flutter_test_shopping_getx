import 'package:flutter/material.dart';
import 'package:flutter_test_shopping_getx/core/data/model/database/item_model.dart';

Widget historyCart(ItemModel item) {
  return Container(
    height: 125,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey, width: 2),
    ),
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Container(
            height: 115,
            width: 115,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(
                  item.image.toString(),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Container(
              height: 115,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${item.name}",
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Price :${item.price} \$"),
                        Text("Off :${item.discount} %"),
                      ],
                    ),
                    Text("Quantity :${item.quantity}"),
                    Text("Amount :${item.payment} \$"),
                    Text("${item.date}"),
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
