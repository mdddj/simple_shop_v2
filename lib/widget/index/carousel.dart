import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';

import '../../constant/app_constant.dart';
import '../image/simple_image.dart';
import '../loading/skeleton.dart';

/// 轮播图组件
class CarouselComponent extends StatefulWidget {
  /// 图片列表
  final List<String> images;

  ///图片被选中回调
  final ValueChanged<int>? onTap;

  ///图片下标变化回调
  final Function(int, int)? onChangle;

  ///构造
  const CarouselComponent({Key? key, required this.images, this.onTap,this.onChangle})
      : super(key: key);

  @override
  State<CarouselComponent> createState() => _CarouselComponentState();
}

class _CarouselComponentState extends State<CarouselComponent> {
  int currImageIndex = 1;
  @override
  Widget build(BuildContext context) {
    return _renderCarousel();
  }

  Widget _renderCarousel() {
    return Stack(
      children: [
        Carousel(
          images: widget.images.map(_builderItem).toList(),
          onImageTap: (index) => widget.onTap?.call(index),
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
          onImageChange: (a,b){
            if(mounted){
              setState(() {
                currImageIndex = b+1;
              });
            }
            widget.onChangle?.call(a,b);
          },
        ),
        Positioned(
          bottom: kDefaultPadded,
          right: kDefaultPadded,
          child: Container(
            height: 30,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadded),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(.5),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Text(
              '$currImageIndex / ${widget.images.length}',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
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
