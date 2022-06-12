import 'package:dataoke_sdk/model/category.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constant/app_constant.dart';
import '../../../functions/fun_type.dart';
import '../../../util/extended_util.dart';
import '../../../util/widget_util.dart';

/// 超级分类图标选择类型组件
class CategoryIconTheme extends StatelessWidget {

  /// 选中某个项目回调
  final CategorySelectd? onSelect;

  /// 超级大分类列表
  final List<Category>? categorys;

  ///构造
  const CategoryIconTheme(this.onSelect, this.categorys, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kCategoryComponentHeight,
      padding: const EdgeInsets.only(left: kDefaultPadded),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: itemBuild,
        itemCount: categorys!.length,
      ),
    );
  }

  /// 子项目布局
  Widget itemBuild(BuildContext context,int index) {
    final item = categorys![index];
    return buildItem(item, index);
  }

  ///子项目布局
  Widget buildItem(Category category, int index) {
    return GestureDetector(
      onTap: () {
        onSelect!(index, category);
      },
      child: Container(
        width: kCategoryComponentHeight - 30,
        height: kCategoryComponentHeight,
        margin: const EdgeInsets.only(right: kDefaultPadded),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
                child: Container(
              width: (kCategoryComponentHeight - 30) * .8,
              color: Colors.grey[200],
              child: buildExtendedImage(
                  category, (kCategoryComponentHeight - 30) * .8),
            )),
            Text('${category.cname}'.tr,maxLines: 1,overflow: TextOverflow.ellipsis,style: const TextStyle(
              fontSize: 12
            ),)
          ],
        ),
      ),
    );
  }

  /// 图片加载
  Widget buildExtendedImage(Category category, double size) =>
      ExtendedImage.network(
        category.cpic!.imageUrl(),
        width: size,
        height: size,
        cache: true,
        loadStateChanged: WidgetUtil.instance.s,
      );
}
