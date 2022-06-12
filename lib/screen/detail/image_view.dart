import 'package:dataoke_sdk/model/product.dart';
import 'package:extended_image/extended_image.dart';
import 'package:extended_list/extended_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_constant.dart';
import '../../model/product_detail_model.dart';
import '../../util/extended_util.dart';
import '../../util/widget_util.dart';

class ImageView extends StatelessWidget {
  final Product? product;

  const ImageView({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return Container();
    }
    var list = <DetailImage>[];
    if (product!.detailPics!.isNotEmpty) {
      list = detailImageFromJson(product!.detailPics!);
    }
    return Container(
      width: Get.width,
      margin: const EdgeInsets.only(top: kDefaultPadded),
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadded),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadded),
            child: WidgetUtil.instance.renderTitle('商品详情'.tr),
          ),
          const SizedBox(
            height: kDefaultPadded / 2,
          ),
          if (list.isEmpty)
             Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: Text('暂无详情'.tr)),
            ),
          if (list.isNotEmpty)
            ExtendedListView.builder(
              itemBuilder: (c, i) {
                return renderItem(list[i]);
              },
              itemCount: list.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              extendedListDelegate: const ExtendedListDelegate(),
            )
        ],
      ),
    );
  }

  Widget renderItem(DetailImage img) {
    if(img.img!=null){
      return ExtendedImage.network(
        img.img!.imageUrl(),
        cache: false,
        fit: BoxFit.cover,
      );
    }
    return const SizedBox();
  }
}
