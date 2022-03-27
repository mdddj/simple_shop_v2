import 'package:dataoke_sdk/model/product.dart';
import 'package:flutter/material.dart';

import '../../../constant/app_constant.dart';
import '../../product/product.dart';

/// 限时抢购首页组件
class TimebuyComponent extends StatelessWidget {
  final List<Product> products;

  const TimebuyComponent({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadded),
      child: renderBody(),
    );
  }

  Column renderBody() {
    return Column(
      children: [renderProducts()],
    );
  }

  Widget renderTitle() {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kDefaultPadded / 2, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            '限时抢购',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget renderProducts() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: products.map(renderItemLayout).toList(),
      ),
    );
  }

  Widget renderItemLayout(Product product) {
    return ProductLayout(product: product);
  }
}
