import 'package:dataoke_sdk/model/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_constant.dart';
import '../../util/extended_util.dart';
import '../../util/widget_util.dart';
import '../image/simple_image.dart';
import 'product_widgets.dart';

class SimpleCard extends StatelessWidget {
  final Product product;

  const SimpleCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => WidgetUtil.instance.detailPage(product: product),
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 90,
                height: 90,
                child: SimpleImage(
                  url: product.mainPic!,
                ),
              ),
              const SizedBox(
                width: kDefaultPadded,
              ),
              Expanded(
                  child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 90),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${product.dtitle}'),
                    Text(
                      '${product.actualPrice?.toRMB()}',
                      style: TextStyle(color: Get.theme.primaryColor),
                    ),
                    ProductWidgets(
                      product: product,
                    )
                  ],
                ),
              ))
            ],
          )),
    );
  }
}
