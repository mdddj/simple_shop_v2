import 'package:dataoke_sdk/model/product.dart';
import 'package:extended_list/extended_list.dart';
import '../../constant/app_constant.dart';
import '../../model/product_detail_model.dart';
import '../../util/widget_util.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import '../../util/extended_util.dart';
import 'package:get/get.dart';

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
      margin: EdgeInsets.only(top: kDefaultPadded),
      padding: EdgeInsets.symmetric(vertical: kDefaultPadded),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadded),
            child: WidgetUtil.instance.renderTitle('商品详情'),
          ),
          SizedBox(
            height: kDefaultPadded / 2,
          ),
          if (list.isEmpty)
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text('暂无详情')),
              ),
            ),
          if (list.isNotEmpty)
            ExtendedListView.builder(
              itemBuilder: (c, i) {
                return renderItem(list[i]);
              },
              itemCount: list.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              extendedListDelegate: ExtendedListDelegate(),
            )
        ],
      ),
    );
  }

  Widget renderItem(DetailImage img) {
    final w = Get.width;
    return Container(
      child: ExtendedImage.network(
        '${img.img!.imageUrl()}',
        width: w,
        height: w,
        loadStateChanged: WidgetUtil.instance.s,
        cache: false,
      ),
    );
  }
}
