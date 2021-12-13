import 'package:dataoke_sdk/dd_taoke_sdk.dart';
import 'package:dataoke_sdk/model/activity_link_result.dart';
import 'package:dataoke_sdk/params/activity_link_param.dart';
import 'package:get/get.dart';
import '../../util/extended_util.dart';

class TaobaoActivityLogic extends GetxController {
  late final String activityId;

  var pageId = RxInt(1);

  var activityLinks = Rx<ActivityLinkResult?>(null); // 活动转链结果

  /// 活动转链
  Future<void> getLinks() async {
    var result = await DdTaokeSdk.instance
        .getActivityLink(ActivityLinkParam(promotionSceneId: activityId));

    if (result != null) {
      activityLinks.value = result;
      await result.clickUrl.launchUrl();
      update();
    }
  }

  /// 初始化活动id参数
  void init(String id) => activityId = id;

  @override
  void onReady() {
    getLinks();
    super.onReady();
  }
}
