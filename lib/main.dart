import 'dart:ui' as ui;

import 'package:dd_js_util/dd_js_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'controller/app_controller.dart';
import 'main_tabbars.dart';
import 'provider/app.dart';
import 'provider/factory.dart';

///入口函数
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BaseApi.host = 'https://itbug.shop';
  Get.put(AppController());
  
  await GetStorage.init();
  PaintingBinding.instance.imageCache.maximumSizeBytes = 1000 << 20;
  runApp(const MyApp());
}

///APP实例
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: ChangeNotifierProvider<AppProvider>(
        create: (BuildContext context) => AppProvider(),
        child: Consumer<AppProvider>(builder: (BuildContext context, value, Widget? child) {
          return GetCupertinoApp(
            title: '梁典典',
            debugShowCheckedModeBanner: false,
            locale: ui.window.locale,
            theme: CupertinoThemeData(
                brightness:value.themModel,
            ),
            home: const MainTabbars(),
          );
        },),
      ),
    );
  }
}
