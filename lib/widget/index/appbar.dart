import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_constant.dart';


class CustomAppbarDele extends SliverPersistentHeaderDelegate{
  final Function? menuIconHandle;

  CustomAppbarDele({this.menuIconHandle});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Appbar(
      onOpenMenu: menuIconHandle,
    );
  }

  @override
  double get maxExtent => kToolbarHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;

}


class Appbar extends StatelessWidget {
  final Function? onOpenMenu;

  const Appbar({Key? key, this.onOpenMenu}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      margin: EdgeInsets.only(top: Get.mediaQuery.padding.top),
      padding: const EdgeInsets.only(top: 8),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: kDefaultPadded,
              ),
              IconButton(icon: const Icon(Icons.menu), onPressed: onOpenMenu as void Function()?),
              Expanded(child: buildRightIcons())
            ],
          ),
          Positioned(child: buildCenterTitle())
        ],
      ),
    );
  }

  Widget buildRightIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        const SizedBox(
          width: kDefaultPadded,
        )
      ],
    );
  }

  Widget buildCenterTitle() {
    return Container(
      alignment: Alignment.center,
      child: Text(kAppName.tr, style: Get.theme.textTheme.headline6),
    );
  }
}
