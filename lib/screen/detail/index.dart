import 'dart:convert';

import 'package:after_layout/after_layout.dart';
import 'package:dataoke_sdk/dd_taoke_sdk.dart';
import 'package:dataoke_sdk/model/coupon_link_result.dart';
import 'package:dataoke_sdk/model/product.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flustars/flustars.dart' hide WidgetUtil;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_constant.dart';
import '../../ext/string.dart';
import '../../mixin/detail_mixin.dart';
import '../../util/extended_util.dart';
import '../../util/widget_util.dart';
import '../../widget/index/carousel.dart';
import '../../widget/loading/loading_widget.dart';
import '../other/help.dart';
import 'brand_info.dart';
import 'image_view.dart';
import 'like_list.dart';

///产品详情页面
class DetailIndex extends StatefulWidget {

  ///产品模型
  final Product? product;

  ///构造
  const DetailIndex({Key? key, this.product}) : super(key: key);

  @override
  _DetailIndexState createState() => _DetailIndexState();
}

class _DetailIndexState extends State<DetailIndex>
    with AfterLayoutMixin<DetailIndex>, DetailMixin {
  final scrollController = ScrollController();

  bool loading = true;
  String? productId;
  Product? detail;
  CouponLinkResult? tkl;
  Map<String, int> imgs = {};
  List<Product> likeProducts = [];



  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(jsonEncode(widget.product?.toJson()));
    if (loading) return LoadingWidget(appBar: _renderAppbar(),);
    return buildScaffold();
  }

  CupertinoNavigationBar _renderAppbar(){
    return  CupertinoNavigationBar(
      middle: Text('${detail == null ? '产品详情' : detail!.dtitle}'),
    );
  }

  Widget buildScaffold() {
    return CupertinoPageScaffold(
      navigationBar:_renderAppbar(),
      child: SafeArea(
        child: Stack(
          children: [
            ListView.builder(
              itemBuilder: _builder,
              itemCount: 5,
              controller: scrollController,
            ),
            renderBottomAction(),
          ],
        ),
      ),
    );
  }

  Widget _builder(_, index) {
    switch (index) {
      case 0:
        return Container(
          child: renderGroup1(),
        );
      case 1:
        return BrandInfo();
      case 2:
        return LikeProducts(
          products: likeProducts,
        );
      case 3:
        return ImageView(
          product: detail,
        );
      case 4:
        return SizedBox(
          height: 64,
        );
      default:
        return Container();
    }
  }

  Positioned renderBottomAction() {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey[200]!)),
          ),
          child: Row(
            children: [
              SizedBox(width: 12,),
              GestureDetector(
                  child: Icon(CupertinoIcons.info),
                  onTap: () => Get.to(() => HelpPage())),
              SizedBox(width: 12,),
              Expanded(
                  child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: btn1(),
                    ),
                  ),
                  SizedBox(width: 12,),
                  Flexible(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: btn2(),
                    ),
                  )
                ],
              )),
              SizedBox(width: 12,)
            ],
          ),
        ));
  }

  Widget btn1() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: tkl == null ? null : () => copyTkl(tkl!.tpwd,context: context),
      child: Text(
        '复制口令',
      ),
    );
  }

  Widget btn2() {
    return CupertinoButton.filled(
      padding: EdgeInsets.zero,
      onPressed: tkl == null ? null : () => tkl!.couponClickUrl!.tryLaunch(),
      child: Text('领券'),
    );
  }

  Widget renderGroup1() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
      child: Column(
        children: [
          renderImages(),
          renderPrice(),
          renderTitle(),
          renderTags(),
          d(),
          renderDiscount(),
        ],
      ),
    );
  }

  Widget renderDiscount() {
    if (detail == null) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.all(kDefaultPadded),
      child: Row(
        children: [
          Container(
              height: 30,
              width: 60,
              child: WidgetUtil.instance.renderListTileTitle('优惠')),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                    color: Colors.pink.withOpacity(.07),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Text(
                  '${NumUtil.getNumByValueDouble(detail!.couponPrice, 0)}元隐藏券',
                  style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Spacer(),
          CupertinoButton(child:Text(
            '去领取',
          ) , onPressed: ()=>openTb(tkl!.couponClickUrl!))
        ],
      ),
    );
  }

  Widget d() {
    if (detail == null) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadded,
      ),
      margin: EdgeInsets.only(top: kDefaultPadded),
      height: 1,
      color: Colors.grey[200],
    );
  }

  Widget renderTags() {
    if (detail == null || detail!.subdivisionRank == 0) {
      return Container();
    }
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadded, vertical: 6),
      child: Wrap(
        alignment: WrapAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.orange.withOpacity(.23))),
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadded / 2),
            child: Text(
              '${detail!.subdivisionName}喜爱榜No.${detail!.subdivisionRank}',
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget renderTitle() {
    if (detail == null) {
      return Container();
    }
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: kDefaultPadded),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        '${detail!.title}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: kDefaultPadded,
            ),
            Column(
              children: [
                Icon(CupertinoIcons.person_2_fill,color: CupertinoColors.inactiveGray,),
                Text(
                  '${detail!.monthSales}人已领',
                  style: TextStyle(fontSize: 10, color: CupertinoColors.inactiveGray),
                )
              ],
            ),
            SizedBox(
              width: 6,
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 6),
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadded),
          alignment: Alignment.centerLeft,
          child: ExpandableText(
            '${detail!.desc}',
            expandText: '展开',
            collapseText: '收起',
            maxLines: 2,
            style: TextStyle(color: Colors.grey),
            linkColor: Colors.black,
          ),
        )
      ],
    );
  }

  Widget renderPrice() {
    if (detail == null) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.all(kDefaultPadded),
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${detail!.actualPrice.toRMB()}',
            style: TextStyle(fontSize: 22, color: Colors.pink),
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            '淘宝价${detail!.originalPrice.toRMB()}',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                decoration: TextDecoration.lineThrough),
          )
        ],
      ),
    );
  }

  Widget renderImages() {
    if (detail == null) {
      return Container();
    }
    return AspectRatio(
        aspectRatio: 1,
        child: CarouselComponent(images: detail!.imgs!.split(',')));
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    final result = await DdTaokeSdk.instance
        .getDetailBaseData(productId: '${widget.product!.id}');

    if (result != null) {
      var similarList = result.similarProducts ?? [];
      if (mounted) {
        setState(() {
          detail = result.info;
          tkl = result.couponInfo;
          likeProducts = similarList;
          loading = false;
        });
      }
    }
  }
}
