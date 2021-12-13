import 'package:dataoke_sdk/model/category.dart';
import '../../widget/category/category_select_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef OnSelect = void Function(Category? category);

// 分类选择小部件
class SelectCategory extends StatelessWidget {
  final OnSelect? selected;
  final List<Category>? categorys;
  final Category? currentCategory;

  const SelectCategory(
      {Key? key, required this.selected, this.categorys, this.currentCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return renderBody();
  }

  Padding renderBody() {
    final isCurr = currentCategory != null;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () {
            Get.dialog<Category>(CategorySelectDialog(
              categorys: categorys,
            )).then((value) {
              if (value != null) {
                if (selected != null) {
                  selected!(value);
                }
              }
            });
          },
          child: Chip(
            label: Text(isCurr ? '${currentCategory!.cname}' : '类别'),
            deleteIcon: Icon(
              Icons.arrow_drop_down_sharp,
              color: Colors.black,
            ),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(55))),
            backgroundColor: isCurr ? Get.theme.highlightColor : Colors.white,
            onDeleted: () {},
          ),
        ),
      ),
    );
  }
}
