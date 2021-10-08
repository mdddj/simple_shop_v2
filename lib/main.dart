import 'package:dd_taoke_sdk/network/util.dart';
import 'package:provider/provider.dart';
import 'controller/app_controller.dart';
import 'provider/factory.dart';
import 'service/app_service.dart';
import 'service/impl/api_service_impl.dart';
import 'translation/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'dart:ui' as ui;

import 'package:get_storage/get_storage.dart';

import 'main_tabbars.dart';

///
void main() async {
  DdTaokeUtil.instance.init('https://itbug.shop', '443', proxy: '');
  Get.put(AppService());
  Get.put(ApiService());
  Get.put(AppController());
  await GetStorage.init();
  PaintingBinding.instance!.imageCache!.maximumSizeBytes = 1000 << 20;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: GetMaterialApp(
        title: '梁典典',
        translations: I18n(),
        debugShowCheckedModeBanner: false,
        locale: ui.window.locale,
        defaultTransition: Transition.native,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: Colors.greenAccent
        ),
        home: MainTabbars(),
      ),
    );
  }
}
