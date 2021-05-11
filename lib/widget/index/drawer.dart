import '../../constant/app_constant.dart';
import '../../controller/index_controller.dart';
import '../../screen/top/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 首页的抽屉菜单
class IndexDarwer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          renderHeader(),
          Divider(),
          ...renderMenu1(),
          // Divider(),
          // ...renderMenu2()
        ],
      ),
    );
  }

  // 菜单组一
  List<Widget> renderMenu1() {
    final ctrl = IndexController.find;
    return [
      ListTile(
        leading: Icon(Icons.whatshot_rounded),
        title: Text('排行榜'),
        onTap: () {
          Get.to(() => TopIndex());
          ctrl.scaffoldKey.currentState!.openEndDrawer();
        },
      ),
      // ListTile(
      //   leading: Icon(Icons.content_cut_outlined),
      //   title: Text('每日半价'),
      // ),
      // ListTile(
      //   leading: Icon(Icons.confirmation_num),
      //   title: Text('折上折'),
      // ),
    ];
  }

  // 菜单组二
  List<Widget> renderMenu2() {
    return [
      ListTile(
        leading: Icon(Icons.shopping_bag),
        title: Text('品牌联盟'),
      ),
    ];
  }

  // 头部
  Widget renderHeader() {
    return Container(
      padding: EdgeInsets.all(kDefaultPadded / 2),
      margin: EdgeInsets.only(top: Get.mediaQuery.padding.top),
      child: Text(
        '典典的小卖部',
        style: Get.textTheme.headline5,
      ),
    );
  }
}
