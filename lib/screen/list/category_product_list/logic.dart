import 'dart:convert';

import 'package:dataoke_sdk/dataoke_sdk.dart';
import 'package:dataoke_sdk/model/category.dart';
import 'package:dd_js_util/api/request_params.dart';
import 'package:dd_models/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../functions/fun_verify.dart';

class CategoryProductListLogic extends GetxController {
  static CategoryProductListLogic get instance =>
      Get.find<CategoryProductListLogic>();
  RxString panentId = ''.obs; // 父分类id
  RxString childId = ''.obs; // 子分类id

  RxInt pageId = 1.obs; // 第几页
  RxString sort = '0'.obs; // 排序

  RxList<Product> products = <Product>[].obs; // 显示的商品列表

  ScrollController scrollController = ScrollController();
  EasyRefreshController refreshController = EasyRefreshController();

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

  /// 刷新
  Future<void> fresh() async {
    scrollController.jumpTo(0);
    products.clear();
    pageId.value = 1;
    await loadData();
  }

  /// 用户需要排序
  Future<void> onSort(String sortValue) async {
    scrollController.jumpTo(0);
    sort.value = sortValue;
    products.clear();
    pageId.value = 1;
    await fresh();
  }

  /// 组装参数
  ProductListParam get getParams => ProductListParam(
      pageId: '${pageId.value}',
      pageSize: '10',
      sort: sort.value,
      cids: '${childId.value},${panentId.value}');

  /// 加载数据
  Future<bool> loadData() async {
    final result = await DdTaokeSdk.instance.getProducts(param: getParams, requestParamsBuilder: (RequestParams requestParams) {
      return requestParams;
    });
    if (!isNull(result)!) {
      products.addAll(result!.list!);
      update();
    }
    return result != null;
  }

  /// 加载下一页
  Future<void> nextPage() async {
    pageId.value += 1;
    await loadData();
    update();
  }
}
