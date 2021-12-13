import 'package:dataoke_sdk/dd_taoke_sdk.dart';
import 'package:dataoke_sdk/model/product.dart';
import 'package:dataoke_sdk/params/nine_nine_param.dart';
import 'package:get/get.dart';

class NineNineLogic extends GetxController {
  var page = 1.obs;
  var pageSize = 20;
  var nineCid = RxInt(-1);
  var products = RxList<Product>([]);
  var loading = false.obs;

  /// 加载商品
  Future<void> getProducts() async {
    final result = await DdTaokeSdk.instance.getNineNineProducts(
        param: NineNineParam(
            pageSize: '$pageSize',
            pageId: '${page.value}',
            nineCid: '$nineCid'));
    if (result != null && result.list != null) {
      products.addAll(result.list!);
      print('获取到商品:${result.list!.length}');
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
