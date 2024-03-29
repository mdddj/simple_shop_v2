import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../constant/app_constant.dart';
import '../../widget/loading/simple_loadings.dart';
import '../../widget/product/simple_card.dart';
import 'logic.dart';

/// 九块九包邮产品
class NineNinePage extends StatefulWidget {
  const NineNinePage({Key? key}) : super(key: key);

  @override
  NineNinePageState createState() => NineNinePageState();
}

class NineNinePageState extends State<NineNinePage> with SingleTickerProviderStateMixin {
  final NineNineLogic logic = Get.put(NineNineLogic());

  int _currIndex = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('9快9包邮'),
      ),
      child: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(kDefaultPadded),
                child: CupertinoSlidingSegmentedControl<int>(children: const {
                  1: Text('9.9'),
                  2: Text('19.9'),
                  3: Text('29.9')
                }, onValueChanged: (index){
                  if(index==null){
                    return;
                  }
                  setState(() {
                    _currIndex = index;
                  });
                  logic.onTabChanged(index);
                },groupValue: _currIndex,),
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),

                  child:logic.loading.value ? kLoadingWidget : ListView.builder(
                    itemBuilder: _itemBuilder,
                    itemCount: logic.products.length,
                  ),
                ),
              ),
            ],
          );

        }),
      ),
    );
  }

  /// 商品项目卡片
  Widget _itemBuilder(_, index) {
    final product = logic.products[index];
    return SimpleCard(product: product);
  }
}
