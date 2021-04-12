import 'package:after_layout/after_layout.dart';
import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/coupon_link_result.dart';
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:dd_tk_shop/constant/app_constant.dart';
import 'package:dd_tk_shop/mixin/detail_mixin.dart';
import 'package:dd_tk_shop/util/custom_floating_location.dart';
import 'package:dd_tk_shop/util/widget_util.dart';
import 'package:dd_tk_shop/widget/loading/loading_widget.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flustars/flustars.dart' hide WidgetUtil;
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';
import 'package:dd_tk_shop/util/extended_util.dart';

import 'brand_info.dart';
import 'image_view.dart';
import 'like_list.dart';

// 详情页面
class DetailIndex extends StatefulWidget {
  final Product product;

  const DetailIndex({Key key, this.product}) : super(key: key);

  @override
  _DetailIndexState createState() => _DetailIndexState();
}

class _DetailIndexState extends State<DetailIndex>
    with AfterLayoutMixin<DetailIndex>, DetailMixin {
  final scrollController = ScrollController();
  var showToTopButton = false;

  bool loading = true;
  String productId;
  Product detail;
  CouponLinkResult tkl;
  Map<String, int> imgs = {};
  List<Product> likeProducts = [];
  int currImageIndex = 1;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      final px = scrollController.offset;
      if (px > 200.0) {
        if (!showToTopButton) {
          setState(() {
            showToTopButton = true;
          });
        }
      } else {
        if (showToTopButton) {
          setState(() {
            showToTopButton = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return LoadingWidget();
    return buildScaffold();
  }

  Widget buildScaffold() {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "${detail == null ? '详情' : detail.dtitle}",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemBuilder: _builder,
            itemCount: 5,
            controller: scrollController,
          ),
          renderBottomAction(),
        ],
      ),
      floatingActionButton: showToTopButton
          ? FloatingActionButton(
              onPressed: () {
                scrollController.jumpTo(0);
              },
              backgroundColor: Colors.white,
              child: Icon(
                Icons.vertical_align_top,
                color: Colors.black,
              ),
            )
          : null,
      floatingActionButtonLocation: CustomFloatingActionButtonLocation(
          FloatingActionButtonLocation.endFloat, 0, -65),
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
            border: Border(top: BorderSide(color: Colors.grey[200])),
          ),
          child: Row(
            children: [
              IconButton(icon: Icon(Icons.help), onPressed: () {}),
              Expanded(
                  child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    child: Container(
                      width: double.infinity,
                      child: btn1(),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      width: double.infinity,
                      child: btn2(),
                    ),
                  )
                ],
              ))
            ],
          ),
        ));
  }

  Widget btn1() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadded),
      child: MaterialButton(
        onPressed: tkl == null ? null : () => copyTkl(tkl.tpwd),
        child: Text(
          "复制口令",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.black,
        disabledColor: Colors.grey,
      ),
    );
  }

  Widget btn2() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadded),
      child: MaterialButton(
        onPressed: tkl == null ? null : () => openTb(tkl.couponClickUrl),
        child: Text("领券", style: TextStyle(color: Colors.white)),
        color: Colors.black,
        disabledColor: Colors.grey,
      ),
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
    return ListTile(
      leading: WidgetUtil.instance.renderListTileTitle("优惠"),
      title: Row(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
                color: Colors.pink.withOpacity(.07),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Text(
              "${NumUtil.getNumByValueDouble(detail.couponPrice, 0)}元隐藏券",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      trailing: Text(
        "领券",
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
      onTap: () => openTb(tkl.couponClickUrl),
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
    if (detail == null || detail.subdivisionRank == 0) {
      return Container();
    }
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadded, vertical: 6),
      child: Wrap(
        alignment: WrapAlignment.start,
        children: [
          Container(
            child: Text(
              "${detail.subdivisionName}喜爱榜No.${detail.subdivisionRank}",
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.orange.withOpacity(.23))),
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadded / 2),
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
                        "${detail.title}",
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
                Icon(Icons.supervisor_account),
                Text(
                  '${detail.monthSales}人已领',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
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
            "${detail.desc}",
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
            "${detail.actualPrice.toRMB()}",
            style: TextStyle(fontSize: 22, color: Colors.pink),
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            "淘宝价${detail.originalPrice.toRMB()}",
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
    final imgs = getImages(detail.imgs);
    return Stack(
      children: [
        Container(
          width: Get.width,
          height: Get.width,
          child: Swiper(
            itemCount: imgs.keys.length,
            itemBuilder: (c, i) {
              final url = imgs.keys.toList()[i];
              return ExtendedImage.network(
                url.imageUrl(),
                width: Get.width,
                height: Get.width,
                cache: true,
                loadStateChanged: WidgetUtil.instance.s,
              );
            },
            onIndexChanged: (int index) {
              setState(() {
                currImageIndex = index + 1;
              });
            },
          ),
        ),
        Positioned(
          bottom: kDefaultPadded,
          right: kDefaultPadded,
          child: Container(
            height: 30,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadded),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(.5),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Text(
              '$currImageIndex / ${imgs.keys.length}',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    final result = await DdTaokeSdk.instance
        .getDetailBaseData(productId: '${widget.product.id}');

    if (result != null) {
      if (mounted) {
        setState(() {
          detail = result.info;
          tkl = result.couponInfo;
          likeProducts = result.similarProducts;
          loading = false;
        });
      }
    }
  }
}
