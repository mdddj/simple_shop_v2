import 'package:dataoke_sdk/dd_taoke_sdk.dart';
import 'package:dataoke_sdk/model/category.dart';
import 'package:dataoke_sdk/model/product.dart';
import 'package:dataoke_sdk/params/top_param.dart';
import 'package:get/get.dart';

import '../../service/impl/api_service_impl.dart';

class TopController extends GetxController {
  final service = ApiService();
  RxInt page = 1.obs;
  RxList<Product> goods = RxList<Product>([]);
  RxInt cid = 0.obs;
  RxBool loading = true.obs;

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  // 分类被选择
  void onSelect(Category? category) {
    page.value = 1;
    cid.value = category != null ? category.cid! : 0;
    loadData();
  }

  // 加载下一页
  Future<void> nextPage() async {
    page = page + 1;
    await loadData();
  }

  // 刷新
  Future<void> doRefresh() async {
    page.value = 1;
    await loadData();
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
