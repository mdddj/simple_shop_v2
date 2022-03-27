import 'package:dataoke_sdk/model/product.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../product/wall_product_card.dart';

/// 瀑布流商品
class WaterfallsFlowLayout extends StatelessWidget {
  final List<Product>? products;

  const WaterfallsFlowLayout({Key? key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WaterfallFlow.builder(
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          collectGarbage: (List<int> garbages) {
            for (var index in garbages) {
              final provider = ExtendedNetworkImageProvider(
                products![index].mainPic!,
              );
              provider.evict();
            }
          }),
      itemBuilder: _builder,
      itemCount: products!.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }

  Widget _builder(_, index) {
    final product = products![index];
    return WallProductCard(product: product);
  }
}
