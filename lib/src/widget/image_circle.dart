import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageCircle extends StatelessWidget {
  final bool isNetwork;
  final String pathImage;
  final double size;

  ImageCircle(this.isNetwork, this.pathImage, this.size);

  @override
  Widget build(BuildContext context) {
    return isNetwork
        ? CircleAvatar(
            radius: size / 2,
            backgroundImage: CachedNetworkImageProvider(pathImage))
        : CircleAvatar(
            radius: size / 2, backgroundImage: AssetImage(this.pathImage));
  }
}
