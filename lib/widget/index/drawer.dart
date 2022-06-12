import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_constant.dart';
import '../../controller/index_controller.dart';
import '../../screen/top/index.dart';

// 首页的抽屉菜单
class IndexDarwer extends StatelessWidget {
  const IndexDarwer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        renderHeader(),
        const Divider(),
        ...renderMenu1(),
        // Divider(),
        // ...renderMenu2()
      ],
    );
  }

  // 菜单组一
  List<Widget> renderMenu1() {
    final ctrl = IndexController.find;
    return [
      ListTile(
        leading: const Icon(Icons.whatshot_rounded),
        title: const Text('排行榜'),
        onTap: () {
          Get.to(() => const TopIndex());
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
      const ListTile(
        leading: Icon(Icons.shopping_bag),
        title: Text('品牌联盟'),
      ),
    ];
  }

  // 头部
  Widget renderHeader() {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadded / 2),
      margin: EdgeInsets.only(top: Get.mediaQuery.padding.top),
      child: Text(
        kAppName,
        style: Get.textTheme.headline5,
      ),
    );
  }
}
