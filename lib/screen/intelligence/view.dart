import 'package:dataoke_sdk/dataoke_sdk.dart';
import 'package:dd_js_util/api/request_params.dart';
import 'package:flustars_flutter3/flustars_flutter3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_constant.dart';
import '../../constant/color_constant.dart';
import '../../util/extended_util.dart';
import '../../widget/image/simple_image.dart';
import '../../widget/loading/simple_loadings.dart';
import 'logic.dart';

class IntelligencePage extends StatefulWidget {
  const IntelligencePage({Key? key}) : super(key: key);

  @override
  IntelligencePageState createState() => IntelligencePageState();
}

class IntelligencePageState extends State<IntelligencePage>
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
        return CupertinoPageScaffold(
          navigationBar: _appbar,
          child: SafeArea(
            child: logic.initLoading.value
                ? kLoadingWidget
                : ListView.builder(
                    itemBuilder: _builder, itemCount: logic.list.length),
          ),
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
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.only(
          top: index == 0 ? 12 : 0, left: 12, right: 12, bottom: 12),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('梁典典'),
              const SizedBox(width: 6),
              Text(
                '${TimelineUtil.formatByDateTime(item.updateTime!, locale: 'zh')}发布',
                style: TextStyle(color: kTextColor),
              )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: SimpleImage(
                  url: item.img!,
                  radius: 8,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                  child: Container(
                constraints: const BoxConstraints(minHeight: 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${item.title}'),
                  ],
                ),
              ))
            ],
          ),
          const SizedBox(height: kDefaultPadded,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CupertinoButton(
                  child: const Text('复制文案'),
                  onPressed: () => Utils().copy(item.title)),
              CupertinoButton.filled(
                padding: const EdgeInsets.symmetric(horizontal: kDefaultPadded* 2,vertical: 2),
                  onPressed: () async {
                    final result = await DdTaokeSdk.instance
                        .getCouponsDetail(taobaoGoodsId: item.itemId!, requestParamsBuilder: (RequestParams requestParams) {
                          return requestParams;
                    });
                    if (result != null) {
                      await Utils().openTaobao(result.couponClickUrl!);
                    }
                  },
                  child: const Text('去购买')),
            ],
          )
        ],
      ),
    );
  }

  CupertinoNavigationBar get _appbar => const CupertinoNavigationBar(
        middle: Text('优惠情报'),
      );
// bottom: AppbarBottomTabbar(
//   controller: tabController,
//   changeIndex: IntelligenceLogic.instance.onChange,
// ));
}
