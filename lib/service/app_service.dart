
import 'package:get/get.dart';

import '../util/net/network/http_request.dart';

/// app 服务类
class AppService extends GetxService{

  @override
  void onInit() {
    HttpRequest.init();
    super.onInit();
  }

}