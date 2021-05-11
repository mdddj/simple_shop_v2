import 'package:dd_taoke_sdk/model/product.dart';
import '../../util/extended_util.dart';
import '../../util/widget_util.dart';
import '../price/simple_price_layout.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'product_widgets.dart';

/// 瀑布流卡片
class WallProductCard extends StatelessWidget {
  final Product product;

  const WallProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetUtil.instance.detailPage(product: product);
      },
      child: PhysicalModel(
        color: Colors.grey[200]!,
        elevation: 3,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _image(constraints),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${product.dtitle}',
                          style: Get.textTheme.bodyText1,
                        ),
                        SizedBox(height: 4),
                        SimplePrice(
                          product: product,
                        ),
                        ProductWidgets(
                          product: product,
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _image(constraints) {
    return Stack(
      children: [
        ExtendedImage.network(
          Utils().imageHeaderHandle(product.mainPic!),
          width: constraints.maxWidth,
          height: constraints.maxWidth,
          loadStateChanged: WidgetUtil.instance.s,
          cache: true,
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          shape: BoxShape.rectangle,
        ),
      ],
    );
  }
}
