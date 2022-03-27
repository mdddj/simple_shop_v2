import 'package:dataoke_sdk/dd_taoke_sdk.dart';
import 'package:dataoke_sdk/model/category.dart';
import 'package:dataoke_sdk/model/product.dart';
import 'package:dataoke_sdk/params/product_list_param.dart';
import 'package:get/get.dart';

import '../constant/api_constant.dart';
import '../service/impl/api_service_impl.dart';

/// 初始化 app 全局属性
class AppController extends GetxController {

  ///实例
  static AppController get instance => Get.find<AppController>();

  ///部分api
  final api = ApiService.instance;

  ///产品超级分类
  RxList<Category> categorys = RxList<Category>([]);

  ///首页的产品列表
  RxList<Product> products = RxList<Product>([]);

  ///分页
  int _page = 1;

  @override
  void onInit() {
    loadCategory();
    Future.delayed(Duration(milliseconds: 300),fetchIndexProduct);
    super.onInit();
  }

  /// 加载分类
  void loadCategory() {
    DdTaokeSdk.instance.getCategorys().then((value) {
      categorys.addAll(value);
      update();
    });
  }

  ///加载产品数据
  ///page -- 第几页,不传默认加载第1页
  Future<void> fetchIndexProduct({int? page})async {
    final result = await DdTaokeSdk.instance.getProducts(
        param: ProductListParam(pageId: '${page ?? _page}', pageSize: '$kDefaultPageSize'));
    if(result!=null){
      products.addAll(result.list??[]);
      _page ++;
      update();
    }
  }
}
