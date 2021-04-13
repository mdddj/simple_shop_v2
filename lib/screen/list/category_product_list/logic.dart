import 'dart:convert';

import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/category.dart';
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:dd_taoke_sdk/params/product_list_param.dart';
import 'package:dd_tk_shop/functions/fun_verify.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CategoryProductListLogic extends GetxController {
  var panentId = ''.obs; // 父分类id
  var childId = ''.obs; // 子分类id

  var pageId = 1.obs; // 第几页
  var sort = 0.obs; // 排序

  var products = <Product>[].obs; // 显示的商品列表

  @override
  void onInit() {
    getCategoryWithCatch();
    loadData();
    super.onInit();
  }

  /// 从本地读取分类数据
  void getCategoryWithCatch() {
    final box = GetStorage();
    final json = box.read('category-load');
    final category = Category.fromJson(jsonDecode(json));
    final _childId = box.read('category-child');
    panentId.value = category.cid.toString();
    childId.value = _childId.toString();
    update();
  }

  /// 组装参数
  ProductListParam get getParams => ProductListParam(
      pageId: '${pageId.value}',
      pageSize: "10",
      sort: '${sort.value}',
      cids: '${childId.value},${panentId.value}');

  /// 加载数据
  Future<void> loadData() async {
    print(jsonEncode(getParams));
    final result = await DdTaokeSdk.instance.getProducts(param: getParams);
    if (!isNull(result)) {
      products.addAll(result.list);
      update();
    }
  }
}
