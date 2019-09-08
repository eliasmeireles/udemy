import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class ImagesCarousel extends StatelessWidget {
  final List imagesUrl;

  ImagesCarousel(this.imagesUrl);
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return AspectRatio(
        aspectRatio: 0.9,
        child: Carousel(
          dotSize: 5,
          autoplay: false,
          boxFit: BoxFit.cover,
          dotSpacing: 10,
          dotIncreasedColor: primaryColor,
          dotColor: primaryColor,
          dotBgColor: Colors.transparent,
          images: imagesUrl.map((url) {
            return NetworkImage(url);
          }).toList(),
        ),
    );
  }
}
