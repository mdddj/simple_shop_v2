import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import '../loading/skeleton.dart';

import '../image/simple_image.dart';
import 'package:flutter/material.dart';

/// 轮播图组件
class CarouselComponent extends StatelessWidget {
  /// 图片列表
  final List<String> images;
  final ValueChanged<int>? onTap;

  const CarouselComponent({Key? key, required this.images, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _renderCarousel();
  }

  Widget _renderCarousel() {
    return Carousel(
      images: images.map(_builderItem).toList(),
      onImageTap: (index) => onTap?.call(index),
      dotSize: 4.0,
      dotSpacing: 15.0,
      dotColor: Colors.lightGreenAccent,
      indicatorBgPadding: 5.0,
      dotBgColor: Colors.grey.withOpacity(.07),
      borderRadius: true,
      defaultImage: Skeleton(
        width: double.infinity,
        height: 200,
      ),
    );
  }

  Widget _builderItem(String image) {
    return Container(
      child: SimpleImage(
        url: image,
      ),
    );
  }
}
