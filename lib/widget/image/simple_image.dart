import '../../util/widget_util.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import '../../util/extended_util.dart';

/// 简单的图片
/// 需要直系父亲组件声明宽高
class SimpleImage extends StatelessWidget {
  final String url;

  const SimpleImage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child: ExtendedImage.network(
            url.imageUrl(),
            width: double.infinity,
            height: double.infinity,
            loadStateChanged: WidgetUtil.instance.s,
            cache: true,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}
