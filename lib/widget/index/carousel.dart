import 'package:dd_tk_shop/constant/app_constant.dart';
import 'package:dd_tk_shop/controller/carousel/carousel_ctrl.dart';
import 'package:dd_tk_shop/util/widget_util.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:dd_tk_shop/util/extended_util.dart';

/// 轮播图组件
class Carousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CarouselController>(
        init: CarouselController(),
        builder: (_) {
          return buildBody(_);
        });
  }

  Container buildBody(CarouselController _) {
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadded),
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          final _item = _.topics[index];
          var _image;
          if (_item.banner.isNotEmpty) {
            _image = _item.banner[0];
          }

          return ExtendedImage.network('${_image.toString().imageUrl()}',cache: true,
          fit: BoxFit.contain,width: double.infinity,height: 150,
          loadStateChanged: WidgetUtil.instance.s,);
        },
        itemCount: _.topics.length,
        autoplay: _.topics.isNotEmpty,
        pagination: new SwiperPagination(),
      ),
    );
  }
}
