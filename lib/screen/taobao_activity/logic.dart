import 'package:dataoke_sdk/dataoke_sdk.dart';
import 'package:dd_js_util/api/request_params.dart';
import 'package:get/get.dart';
import '../../util/extended_util.dart';

class TaobaoActivityLogic extends GetxController {
    String? _activityId;

  RxInt pageId = RxInt(1);

  Rx<ActivityLinkResult?> activityLinks = Rx<ActivityLinkResult?>(null); // 活动转链结果

  /// 活动转链
  Future<void> getLinks() async {
    var result = await DdTaokeSdk.instance
        .getActivityLink(ActivityLinkParam(promotionSceneId: _activityId!), requestParamsBuilder: (RequestParams requestParams) {
          return requestParams;
    });

    if (result != null) {
      activityLinks.value = result;
      await result.clickUrl.launchUrl();
      update();
    }
  }

  /// 初始化活动id参数
  set initId(String id) => _activityId = id;
  String get initId => _activityId!;

  @override
  void onReady() {
    getLinks();
    super.onReady();
  }
}
