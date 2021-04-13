import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class CategoryProductListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryProductListLogic>(
      builder: (logic) {
        return Scaffold(
          appBar: AppBar(title: Text('分类'),),
          body: SingleChildScrollView(
            child: Column(
              children: [

              ],
            ),
          ),
        );
      },
      init: CategoryProductListLogic(),
    );
  }
}
