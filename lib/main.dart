import 'dart:ui' as ui;

import 'package:dataoke_sdk/network/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'controller/app_controller.dart';
import 'main_tabbars.dart';
import 'provider/factory.dart';
import 'service/app_service.dart';
import 'service/impl/api_service_impl.dart';

///入口函数
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DdTaokeUtil.instance.init('https://itbug.shop', '443', proxy: '',debug: false);
  Get.put(AppService());
  Get.put(ApiService());
  Get.put(AppController());
  await GetStorage.init();
  PaintingBinding.instance!.imageCache!.maximumSizeBytes = 1000 << 20;
  runApp(MyApp());
}

///APP实例
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: GetCupertinoApp(
        title: '梁典典',
        debugShowCheckedModeBanner: false,
        locale: ui.window.locale,
        home: MainTabbars(),
      ),
    );
  }
}
