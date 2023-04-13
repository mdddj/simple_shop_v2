import 'package:dataoke_sdk/dataoke_sdk.dart';
import 'package:dd_js_util/api/request_params.dart';
import 'package:dd_models/models/product.dart';
import 'package:get/get.dart';

class NineNineLogic extends GetxController {
  RxInt page = 1.obs;
  int pageSize = 20;
  RxInt nineCid = RxInt(-1);
  RxList<Product> products = RxList<Product>([]);
  RxBool loading = false.obs;

  /// 加载商品
  Future<void> getProducts() async {
    final result = await DdTaokeSdk.instance.getNineNineProducts(
        param: NineNineParam(
            pageSize: '$pageSize',
            pageId: '${page.value}',
            nineCid: '$nineCid'), requestParamsBuilder: (RequestParams requestParams) {
          return requestParams;
    });
    if (result != null && result.list != null) {
      products.addAll(result.list!);
      update();
    }
  }

  /// 刷新
  Future<void> refreshProducts() async {
    changeLoadingState(true);
    page.value = 1;
    products.clear();
    await getProducts();
    changeLoadingState(false);
  }

  /// 加载下一页
  Future<void> nextPage() async {
    page.value = page.value + 1;
    await getProducts();
    update();
  }

  /// 更换类型
  void changeType(int type) {
    nineCid.value = type;
    update();
  }

  /// tab被改变变化
  void onTabChanged(int index) {
    if (index == 0) {
      changeType(-1);
    } else {
      changeType(index);
    }
  }

  /// 改变loading状态
  void changeLoadingState(bool value) {
    loading.value = value;
    update();
  }

  @override
  void onReady() {
    refreshProducts();
    super.onReady();
  }

  @override
  void onInit() {
    debounce<int>(nineCid, (_) {
      refreshProducts();
    });
    super.onInit();
  }
}
