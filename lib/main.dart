import 'package:dd_taoke_sdk/network/util.dart';
import 'package:dd_tk_shop/controller/app_controller.dart';
import 'package:dd_tk_shop/service/app_service.dart';
import 'package:dd_tk_shop/service/impl/api_service_impl.dart';
import 'package:dd_tk_shop/translation/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'dart:ui' as ui;

import 'package:get_storage/get_storage.dart';

import 'main_tabbars.dart';

void main() async {
  DdTaokeUtil.instance.init('http://itbug.shop', '8088', proxy: '');
  Get.put(AppService());
  Get.put(ApiService());
  Get.put(AppController());
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '梁典典',
      translations: I18n(),
      debugShowCheckedModeBanner: false,
      locale: ui.window.locale,
      defaultTransition: Transition.native,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainTabbars(),
    );
  }
}
