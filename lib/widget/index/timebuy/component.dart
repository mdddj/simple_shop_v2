import 'package:dd_taoke_sdk/model/product.dart';
import '../../../constant/app_constant.dart';
import '../../product/product.dart';
import 'package:flutter/material.dart';

/// 限时抢购首页组件
class TimebuyComponent extends StatelessWidget {


  final List<Product>? products;

  const TimebuyComponent({Key? key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return renderBody();
  }

  Container renderBody() {
    return Container(
      child: Column(
        children: [ renderProducts()],
      ),
    );
  }

  Widget renderTitle() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: kDefaultPadded / 2, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
        children: products!.map(renderItemLayout).toList(),
      ),
    );
  }

  Widget renderItemLayout(Product product) {
    return ProductLayout(product: product);
  }
}
