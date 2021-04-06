import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/category.dart';
import 'package:dd_taoke_sdk/model/product.dart';
import 'package:dd_taoke_sdk/params/top_param.dart';
import 'package:dd_tk_shop/service/impl/api_service_impl.dart';
import 'package:get/get.dart';

class TopController extends GetxController {
  final service = ApiService();
  var page = 1.obs;
  var goods = RxList<Product>([]);
  var cid = 0.obs;
  var loading = true.obs;

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  // 分类被选择
  void onSelect(Category category) {
    page.value = 1;
    cid.value = category != null ? category.cid : 0;
    loadData();
  }

  // 加载下一页
  Future<void> nextPage() async {
    page = page + 1;
    loadData();
  }

  // 刷新
  Future<void> doRefresh() async {
    page.value = 1;
    loadData();
  }

  // 加载数据
  Future<void> loadData() async {
    if (page.value == 1) {
      goods.clear();
      update();
    }
    final result = await DdTaokeSdk.instance.getTopProducts(
        param: TopParam(
            rankType: '1',
            pageId: page.value.toString(),
            cid: cid.value.toString()));
    if (page.value == 1) {
      loading.value = false;
    }
    goods.addAllIf(result.isNotEmpty, result);
    update();
  }
}
