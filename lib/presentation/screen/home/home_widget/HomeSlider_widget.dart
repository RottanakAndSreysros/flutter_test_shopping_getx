// ignore: file_names
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_shopping_getx/core/data/model/product_model.dart';
import 'package:get/get.dart';

Widget homeSliderWidget(RxList<ProductModel> imtem) {
  return CarouselSlider(
    items: imtem.map(
      (element) {
        return Builder(
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(element.image.value),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      },
    ).toList(),
    options: CarouselOptions(
      height: 200,
      aspectRatio: 16 / 9,
      viewportFraction: 0.95,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 3),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      enlargeFactor: 0.3,
      //onPageChanged: callbackFunction,
      scrollDirection: Axis.horizontal,
    ),
  );
}
