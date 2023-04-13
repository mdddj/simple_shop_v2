import 'package:dataoke_sdk/dataoke_sdk.dart';
import 'package:dataoke_sdk/model/category.dart';
import 'package:dd_js_util/api/request_params.dart';
import 'package:dd_models/models/product.dart';
import 'package:get/get.dart';

import '../constant/api_constant.dart';

/// 初始化 app 全局属性
class AppController extends GetxController {

  ///实例
  static AppController get instance => Get.find<AppController>();


  ///产品超级分类
  final RxList<Category> _categorys = RxList<Category>([]);

  set categorys(List<Category> values)=>_categorys.value = values;
  List<Category> get categorys => _categorys.toList();

  ///首页的产品列表
  RxList<Product> products = RxList<Product>([]);

  ///分页
  int _page = 1;

  @override
  void onInit() {
    loadCategory();
    Future.delayed(const Duration(milliseconds: 300),fetchIndexProduct);
    super.onInit();
  }

  /// 加载分类
  void loadCategory() {
    DdTaokeSdk.instance.getCategorys().then((value) {
      categorys = value;
      update();
    });
  }

  ///加载产品数据
  ///page -- 第几页,不传默认加载第1页
  Future<void> fetchIndexProduct({int? page})async {
    final params = ProductListParam(pageId: '${page ?? _page}', pageSize: '$kDefaultPageSize');
    final result = await DdTaokeSdk.instance.getProducts(
        param: params, requestParamsBuilder: (RequestParams requestParams) {
          return requestParams.copyWith(data: params.toJson());
    });
    if(result!=null){
      products.addAll(result.list??[]);
      _page ++;
      update();
    }
  }
}
