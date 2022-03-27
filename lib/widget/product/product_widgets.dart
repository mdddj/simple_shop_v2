import 'package:dataoke_sdk/model/product.dart';
import 'package:flutter/cupertino.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: const BoxDecoration(
        color: CupertinoColors.systemPink,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      alignment: Alignment.center,
      child: Text(
        '${product.couponPrice}元直减',
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

}
