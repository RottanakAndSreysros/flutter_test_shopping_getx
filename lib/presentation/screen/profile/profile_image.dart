import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ProfileImage extends StatelessWidget {
  final String imageUrl;

  ProfileImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: PhotoView(
          imageProvider: imageUrl == "asset/images/profile.jpg"
              ? const AssetImage("asset/images/profile.jpg")
              : FileImage(File(imageUrl)),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
        ),
      ),
    );
  }
}
