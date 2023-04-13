import 'package:dd_models/models/product.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../constant/app_constant.dart';
import '../../util/extended_util.dart';
import '../../util/widget_util.dart';

// 商品列表
class ProductListTheme1 extends StatelessWidget {
  final List<Product> products;

  const ProductListTheme1({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate:
            SliverChildBuilderDelegate(builder, childCount: products.length));
  }

  // 每项
  Widget builder(BuildContext context, int index) {
    final item = products[index];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: kDefaultPadded),
      child: ListTile(
        leading: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxHeight + 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('${index + 1}'),
                  ExtendedImage.network(
                    item.mainPic.imageUrl(),
                    width: constraints.maxHeight,
                    height: constraints.maxHeight,
                    shape: BoxShape.rectangle,
                    loadStateChanged: WidgetUtil.instance.s,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                ],
              ),
            );
          },
        ),
        title: Text(item.dtitle,
            style: const TextStyle(fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 4,
            ),
            Text(
              '卖出${item.monthSales}件',
              style: const TextStyle(fontSize: 12),
            ),
            Row(
              children: [
                Text(item.actualPrice.toString(),
                    style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 6),
                Text(item.originalPrice.toString(),
                    style: const TextStyle(
                        fontSize: 12, decoration: TextDecoration.lineThrough)),
              ],
            )
          ],
        ),
        onLongPress: () {},
        onTap: () {
          WidgetUtil.instance.detailPage(product: item);
        },
      ),
    );
  }
}
