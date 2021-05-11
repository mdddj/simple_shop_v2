import 'package:dd_taoke_sdk/model/product.dart';
import '../../constant/app_constant.dart';
import '../../constant/color_constant.dart';
import 'package:flutter/material.dart';

/// 价格布局
class SimplePrice extends StatelessWidget {
  final Product product;

  const SimplePrice({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: '$rmb',
              style: TextStyle(
                  color: kPriceSymbolColor,
                  fontSize: kPriceValueFontSize * kSymbolZoom)),
          TextSpan(text: ' '),
          TextSpan(
              text: product.actualPrice.toString(),
              style: TextStyle(
                  color: kPriceValueColor,
                  fontSize: kPriceValueFontSize,
                  fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }
}
