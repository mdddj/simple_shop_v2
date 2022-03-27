import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../constant/app_constant.dart';
import '../../model/product_detail_model.dart';
import '../../util/extended_util.dart';
import '../../util/widget_util.dart';

///品牌信息
class BrandInfo extends StatelessWidget {

  ///品牌详情
  final ProductDetail? detail;

  ///构造
  const BrandInfo({Key? key, this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (detail == null) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.only(top: kDefaultPadded),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))
      ),
      child: Column(
        children: [
          renderItem(),
          renderItem2(),
        ],
      ),
    );
  }

  /// 店铺
  Widget renderItem2(){
    if(detail!.shopName!.isEmpty){
      return Container();
    }
    return ListTile(
      leading: WidgetUtil.instance.renderListTileTitle('店铺'),
      title: Text('${detail!.shopName}'),
      trailing: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return SizedBox(
          width: constraints.maxHeight + 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                child: ExtendedImage.network(detail!.shopLogo!.imageUrl(),shape:BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(50)),),
              ),
              Icon(Icons.chevron_right,)
            ],
          ),
        );
      },),
    );
  }


  /// 品牌
  Widget renderItem(){
    if(detail!.brandName!.isEmpty){
      return Container();
    }
    return ListTile(
      leading: WidgetUtil.instance.renderListTileTitle('品牌'),
      title: Text('${detail!.brandName}'),
    );
  }
}
