
import '../util/net/network/http_request.dart';
import 'package:get/get.dart';

class AppService extends GetxService{

  @override
  void onInit() {
    HttpRequest.init();
    super.onInit();
  }

}