import 'dart:convert';

import 'package:dd_tk_shop/components/utils.dart';
import 'package:dd_tk_shop/service/api_service.dart';
import 'package:dd_tk_shop/widget/image/simple_image.dart';
import 'package:dd_tk_shop/widget/loading/simple_loadings.dart';

import '../../components/no_shadow_croll_ehavior.dart';
import 'package:extended_image/extended_image.dart';
import 'package:fcontrol_nullsafety/fdefine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fsuper_nullsafety/fsuper_nullsafety.dart';
import 'package:get/get.dart';

import 'abs.dart';
import 'model.dart';

/// 通用详情页面
class PublicDetailView extends StatefulWidget {
  final String goodsId;
  final String type;

  const PublicDetailView({Key? key, required this.goodsId, required this.type}) : super(key: key);

  @override
  _PublicDetailViewState createState() => _PublicDetailViewState();
}

class _PublicDetailViewState extends State<PublicDetailView> implements PublicDetailViewAbs {
  PublicDetailModel? info;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final _info = await fetchData();
      if (mounted) {
        setState(() {
          info = _info;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: BlurHash(hash: 'LgJQ[]~o%0V?tixvNHM}R-xaaeWU'),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: info != null
              ? ScrollConfiguration(
                  behavior: NoShadowScrollBehavior(),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [renderNav(), renderHeader(), renderDetail()],
                    ),
                  ),
                )
              : kLoadingWidget,
        ),
      ],
    );
  }

  /// 导航区域
  Widget renderNav() {
    return Container(
      margin: EdgeInsets.only(top: Get.mediaQuery.padding.top + 12, left: 12, right: 12),
      child: Column(
        children: [
          Row(
            children: [
              // 返回按钮
              IconButton(
                  onPressed: Get.back,
                  icon: FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.grey.shade200,
                    size: 18,
                  ))
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: Image.asset('assets/images/dd.png'),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                '典典为你推荐',
                style: TextStyle(color: Colors.white, fontSize: 15),
              )
            ],
          )
        ],
      ),
    );
  }

  /// 商品信息
  Widget renderDetail() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('商品信息'),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          '销量${info!.sales}件',
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        )
                      ],
                    )
                  ],
                ),
              ),
              ...renderImages(constraints.maxWidth)
            ],
          );
        },
      ),
    );
  }

  /// 图片
  List<Widget> renderImages(double width) {
    return info!.detailImages
        .map((e) => SizedBox(
              width: width,
              child: ExtendedImage.network(
                e,
                width: double.infinity,
                cache: true,
                fit: BoxFit.cover,
                shape: BoxShape.rectangle,
              ),
            ))
        .toList();
  }

  /// 头部容器
  Widget renderHeader() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),
                  child: Text(
                    '${getTypeLabel()}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  '${info!.title}',
                  style: Get.textTheme.headline5!.copyWith(fontSize: 18),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      constraints: BoxConstraints(minHeight: 120),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '券后价',
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                          FSuper(
                              text: '¥ ',
                              style: TextStyle(color: Colors.red, fontSize: 16),
                              spans: [TextSpan(text: '${info!.price}', style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold))],
                              lightOrientation: FLightOrientation.RightTop)
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: SimpleImage(url: info!.goodsImage),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onGetCoupon,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              height: 50,
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${info!.coupon.replaceAll('.00', '')}元隐藏券',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    '去领券 >',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Future<PublicDetailModel?> fetchData() async {
    print('id是:${widget.goodsId}');
    switch (widget.type) {
      case 'pdd':
        return await getPxxDetail();
      case 'wph':
        return await getWphDetail();
      default:
        break;
    }
  }

  /// 加载唯品会详情
  Future<PublicDetailModel?> getWphDetail() async {
    final result = await tkApi.getWphProductInfo(widget.goodsId);
    if (result != null) {
      return PublicDetailModel.fromWph(result);
    }
  }

  /// 加载拼夕夕商品详情
  Future<PublicDetailModel?> getPxxDetail() async {
    final result = await tkApi.ppdDetail(widget.goodsId);
    if (result != null) {
      return PublicDetailModel.fromPdd(result);
    }
  }

  @override
  Future<void> onGetCoupon() async {
    if(info!=null){
      switch(info!.type){
        case '拼多多':
          await pxxGet();
          break;
        default:
          break;
      }
    }
  }


  /// 平夕夕领券
  Future<void> pxxGet({bool onShare = false}) async {
    final urls =  await tkApi.pddCovert(widget.goodsId); // 获取转换成功的链接对象
    if(urls!=null){
      print('转链成功:${jsonEncode(urls)}');
      if(onShare){
        utils.copy(urls['mobile_short_url'],message: '链接已复制');
        return;
      }
      await utils.openLink(urls['mobile_short_url'],urlYs: 'pinduoduo://');
    }

  }

  @override
  Future<void> onShare() async {

  }

  @override
  String getTypeLabel() {
    if (info != null) {
      switch (info!.type) {
        case 'pdd':
          return '拼多多';
      }
    }
    return info!.type;
  }
}
