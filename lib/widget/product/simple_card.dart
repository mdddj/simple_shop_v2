import 'package:dd_taoke_sdk/model/product.dart';
import 'package:dd_tk_shop/widget/image/simple_image.dart';
import 'package:dd_tk_shop/widget/tag/couper_tag.dart';
import 'package:flutter/material.dart';
import 'package:dd_tk_shop/util/extended_util.dart';
import 'package:get/get.dart';

class SimpleCard extends StatelessWidget {
  final Product product;

  const SimpleCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 90,
              height: 90,
              child: SimpleImage(
                url: product.mainPic,
              ),
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${product.dtitle}'),
                CouperTag(product: product),
                Text('${product.actualPrice.toRMB()}',style: TextStyle(color: Get.theme.primaryColor),),
              ],
            ))
          ],
        ));
  }
}
