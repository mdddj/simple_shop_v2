import 'package:dd_models/models/product.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../components/search/repository.dart';
import '../../interface/api.dart';
import '../../provider/app.dart';

class SearchLogic extends GetxController implements ApiInterface {
  static SearchLogic get instance => Get.find<SearchLogic>();

  final SearchRepostory searchRepostory = SearchRepostory();
  RxList<Product> products = <Product>[].obs;
  final searchKeyWorlds = ''.obs;
  RxInt page = 1.obs;
  RxInt pageSize = 10.obs;
  RxString type = '0'.obs;

  /// 输入内容被改变
  void onKeyWorldsChange(String value) {
    searchRepostory.onLoaded = () {
      Get.context!.read<AppProvider>().changeSearchInitState(false);
    };
    searchKeyWorlds.value = value;
    if (value.isEmpty) {
      Get.context!.read<AppProvider>().changeSearchInitState(true);
    }
    update();
  }

  @override
  void onInit() {
    debounce(searchKeyWorlds, searchRepostory.onChangeKeyWorld);
    super.onInit();
  }

  @override
  void onApiError(int? code, String? message) {
    if (code != null && message != null) {}
  }
}
