import 'package:dd_models/models/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 券
class CouperTag extends StatelessWidget {
  final Product? product;

  const CouperTag({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.circular(8)),
      child: Text(
        '${product!.couponPrice.toString()} 优惠券',
        style: TextStyle(color: Get.theme.primaryColorLight),
      ),
    );
  }
}
