import 'package:flutter/cupertino.dart';

import '../ext/string.dart';
import '../util/extended_util.dart';

/// 详情页面的一些方法
mixin DetailMixin {
  ///工具集合
  final util = Utils();


  /// 加载轮播图map
  Map<String, int> getImages(String imageString) {
    var map = <String, int>{};
    final imageList = imageString.split(',');
    for (var i = 0; i < imageList.length; i++) {
      final imgurl = imageList[i];
      map[imgurl] = i + 1;
    }
    return map;
  }


  /// 复制淘口令
  void copyTkl(String? tklString,{BuildContext? context}) {
    util.copy(tklString);
    if(context!=null){
      showCupertinoDialog(context: context, builder:( context){
        return const CupertinoAlertDialog(
          content: Text('复制口令成功,打开淘宝领取优惠券'),
        );
      } ,barrierDismissible: true);
    }
  }

  /// 打开淘宝
  void openTb(String couponClickUrl,{BuildContext? context}) {
    // util.openTaobao(couponClickUrl,context: context);
    couponClickUrl.tryLaunch();
  }
}
