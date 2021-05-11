import 'package:dd_taoke_sdk/model/product.dart';
import '../../constant/app_constant.dart';
import '../../constant/color_constant.dart';
import 'package:flutter/material.dart';

/// 商品的一些相关信息
class ProductWidgets extends StatelessWidget {
  final Product product;

  const ProductWidgets({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [_couponWidget()],
    );
  }

  /// 券面额
  Widget _couponWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: kDangerColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Text(
        '$rmb${product.couponPrice} 元券',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

}
