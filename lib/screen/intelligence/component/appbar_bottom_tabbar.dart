import 'package:flutter/material.dart';


class AppbarBottomTabbar extends StatelessWidget implements PreferredSizeWidget{
  final TabController? controller;
  final ValueChanged<int>? changeIndex;

  const AppbarBottomTabbar({Key? key, this.controller, this.changeIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TabBar(
      isScrollable: true,
      tabs: const [
        Tab(
          text: '全部',
        ),
        Tab(
          text: '整点抢购',
        ),
        Tab(
          text: '天猫超市',
        ),
        Tab(
          text: '超市买返',
        ),
        Tab(
          text: '淘宝',
        ),
      ],
      controller: controller,
      onTap: changeIndex,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48);
}
