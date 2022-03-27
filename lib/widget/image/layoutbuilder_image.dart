import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../util/extended_util.dart';
import '../../util/widget_util.dart';

class LayoutBuilderImage extends StatelessWidget {
  final String? url;
  final BoxConstraints? constraints;

  const LayoutBuilderImage({Key? key, this.url, this.constraints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      url!.imageUrl(),
      width: constraints!.maxWidth,
      height: constraints!.maxWidth,
      cache: true,
      loadStateChanged: WidgetUtil.instance.s,
    );
  }
}
