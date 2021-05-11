import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import '../../constant/color_constant.dart';
import '../../util/extended_util.dart';
import '../../widget/image/simple_image.dart';
import '../../widget/loading/simple_loadings.dart';
import 'package:flustars/flustars.dart' hide WidgetUtil;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'component/appbar_bottom_tabbar.dart';
import 'logic.dart';

class IntelligencePage extends StatefulWidget {
  @override
  _IntelligencePageState createState() => _IntelligencePageState();
}

class _IntelligencePageState extends State<IntelligencePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IntelligenceLogic>(
      builder: (logic) {
        return Scaffold(
          appBar: _appbar as PreferredSizeWidget?,
          body:logic.initLoading.value ? kLoadingWidget : ListView.builder(
              itemBuilder: _builder, itemCount: logic.list.length),
        );
      },
      init: IntelligenceLogic(),
    );
  }

  /// 每项布局
  Widget _builder(_, index) {
    final list = IntelligenceLogic.instance.list;
    final item = list[index];
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(
          top: index == 0 ? 12 : 0, left: 12, right: 12, bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('梁典典'),
              SizedBox(width: 6),
              Text(
                '${TimelineUtil.formatByDateTime(item.updateTime!, locale: 'zh')}发布',
                style: TextStyle(color: kTextColor),
              )
            ],
          ),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: SimpleImage(
                  url: item.img!,
                ),
              ),
              SizedBox(width: 6),
              Expanded(
                  child: Container(
                constraints: BoxConstraints(minHeight: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${item.title}'),
                  ],
                ),
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(onPressed: (){
                Utils().copy(item.title);

              }, child: Text('复制文案')),
              TextButton(onPressed: () async {
              final result =  await DdTaokeSdk.instance.getCouponsDetail(taobaoGoodsId: item.itemId!);
              if(result!=null){
                await Utils().openTaobao(result.couponClickUrl!);
              }
              }, child: Text('去购买')),
            ],
          )
        ],
      ),
    );
  }

  Widget get _appbar => AppBar(
      title: Text('优惠情报'),
      bottom: AppbarBottomTabbar(
        controller: tabController,
        changeIndex: IntelligenceLogic.instance.onChange,
      ));

}
