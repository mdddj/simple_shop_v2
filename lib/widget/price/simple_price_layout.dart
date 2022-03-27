import 'package:dataoke_sdk/model/product.dart';
import 'package:flutter/cupertino.dart';

import '../../constant/app_constant.dart';
import '../../util/extended_util.dart';

/// 价格布局
class SimplePrice extends StatelessWidget {
  final Product product;

  const SimplePrice({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${product.actualPrice?.toRMB()}',
            style: const TextStyle( color: CupertinoColors.systemPink),
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            '淘宝价${product.originalPrice.toRMB()}',
            style: const TextStyle(
                color: CupertinoColors.inactiveGray,
                fontSize: 10,
                decoration: TextDecoration.lineThrough),
          )
        ],
      ),
    );
  }
}
