import 'package:dataoke_sdk/dd_taoke_sdk.dart';
import 'package:dataoke_sdk/model/speider_resullt.dart';
import 'package:dataoke_sdk/params/speider_param.dart';
import 'package:get/get.dart';

class IntelligenceLogic extends GetxController {
  static IntelligenceLogic get instance => Get.find<IntelligenceLogic>();

  var pageId = 1;
  var list = <ListElement>[].obs;
  var type = '4'.obs;
  var initLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();

    debounce(type, (dynamic _) {
      pageId = 1;
      list.clear();
      loadData();
    }, time: Duration(milliseconds: 300));
  }

  /// 加载数据
  void loadData() {
    initLoading.value = true;
    update();
    DdTaokeSdk.instance
        .getSpeiderList(
            param: SpeiderParam(pageId: '$pageId', topic: type.value))
        .then((value) {
      if (value != null) {
        final result = SpeiderResult.fromJson(value);
        result.list!.removeWhere((element) => element.img!.isEmpty);
        list.addAll(result.list!);
      }
      initLoading.value = false;
      update();
    });
  }

  /// 选项变更
  void onChange(int index) {
    switch (index) {
      case 0:
        type.value = '4';
        break;
      case 1:
        type.value = '3';
        break;
      case 2:
        type.value = '2';
        break;
      case 3:
        type.value = '1';
        break;
      case 4:
        type.value = '5';
        break;
      default:
        type.value = '4';
        break;
    }
  }
}
