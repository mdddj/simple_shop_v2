import 'package:dataoke_sdk/dd_taoke_sdk.dart';
import 'package:dataoke_sdk/model/product.dart';
import 'package:dataoke_sdk/params/nine_nine_param.dart';
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
            nineCid: '$nineCid'));
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
