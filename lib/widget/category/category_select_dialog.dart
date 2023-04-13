import 'package:dataoke_sdk/model/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../util/extended_util.dart';

// 弹窗选择分类页面
class CategorySelectDialog extends StatelessWidget {
  final List<Category>? categorys;

  const CategorySelectDialog({Key? key, required this.categorys})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: renderBody(),
    );
  }

  SingleChildScrollView renderBody() {
    return SingleChildScrollView(
      child: Column(
        children: renderList(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        '选择分类',
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: Get.back),
      elevation: 0,
    );
  }

  List<Widget> renderList() {
    return categorys!.map(renderItem).toList();
  }

  Widget renderItem(Category item) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(item.cpic.imageUrl()),
      ),
      title: Text(item.cname),
      onTap: () {
        Get.back(result: item);
      },
      onLongPress: () {},
    );
  }
}
