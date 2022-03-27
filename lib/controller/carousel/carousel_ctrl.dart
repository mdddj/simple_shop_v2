import 'package:get/get.dart';

import '../../model/topic_model.dart';
import '../../service/impl/api_service_impl.dart';

class CarouselController extends GetxController{

  final api = ApiService();

  RxList<Topic> topics = RxList([]);

  @override
  void onInit() {
    getList();
    super.onInit();
  }


  Future<void> getList()async{
    final list =  await api.getTopics();
    topics.addAll(list);
    update();
  }

}