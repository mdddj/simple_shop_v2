import 'package:dd_models/models/product.dart';
import 'package:extended_image/extended_image.dart';
import 'package:extended_list/extended_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_constant.dart';
import '../../util/extended_util.dart';
import '../../util/widget_util.dart';

double get w => (Get.width - (kDefaultPadded * 3)) / 3;

/// 商品横向列表
class ProductHorizontalList extends StatelessWidget {
  final List<Product> products;
  final ValueChanged<Product>? itemOnTap;

  const ProductHorizontalList(
      {Key? key, required this.products, this.itemOnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: w * 1.5,
      child: ExtendedListView.builder(
        itemBuilder: (_, index) {
          return renderItem(products[index]);
        },
        itemCount: products.length,
        scrollDirection: Axis.horizontal,
        extendedListDelegate:
            ExtendedListDelegate(collectGarbage: (List<int> indexs) {
          for (var index in indexs) {
            final provider = ExtendedNetworkImageProvider(
              products[index].mainPic,
            );
            provider.evict();
          }
        }),
      ),
    );
  }

  Widget renderItem(Product item) {
    return GestureDetector(
      onTap: () {
        if (itemOnTap != null) {
          itemOnTap!(item);
        }
      },
      child: Container(
        width: w,
        margin: const EdgeInsets.only(right: kDefaultPadded),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExtendedImage.network(
              item.mainPic.imageUrl(),
              width: w,
              height: w,
              cache: true,
              loadStateChanged: WidgetUtil.instance.s,
            ),
            Text(
              item.dtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              item.actualPrice.toString(),
              style: const TextStyle(color: Colors.pink),
            )
          ],
        ),
      ),
    );
  }
}
