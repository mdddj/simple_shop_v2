import 'package:dataoke_sdk/model/product.dart';
import 'package:flutter/cupertino.dart';

import '../../constant/app_constant.dart';
import '../../constant/color_constant.dart';

/// 价格布局
class SimplePrice extends StatelessWidget {
  final Product product;

  const SimplePrice({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
            text: rmb,
            style: TextStyle(
                color: kPriceSymbolColor,
                fontSize: kPriceValueFontSize * kSymbolZoom)),
        const TextSpan(text: ' '),
        TextSpan(
            text: product.actualPrice.toString(),
            style: TextStyle(
                color: kPriceValueColor,
                fontSize: kPriceValueFontSize,
                fontWeight: FontWeight.bold))
      ]),
    );
  }
}
