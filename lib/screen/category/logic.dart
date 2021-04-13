import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/model/category.dart';
import 'package:get/get.dart';

class CategoryLogic extends GetxController {
  static CategoryLogic get instance => Get.find<CategoryLogic>();

  var categorys = <Category>[];

  var currCategory = Rx<Category>();

  @override
  void onInit() {
    DdTaokeSdk.instance.getCategorys().then((value) {
      categorys.addAll(value);
      if (value.isNotEmpty) changeCurrCategory(value[0]);

      update();
    });
    super.onInit();
  }

  void changeCurrCategory(Category category) {
    currCategory.value = category;
    update();
  }
}
