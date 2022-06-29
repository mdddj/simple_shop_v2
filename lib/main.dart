import 'dart:ui' as ui;

import 'package:dataoke_sdk/network/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'constant/app_constant.dart';
import 'controller/app_controller.dart';
import 'main_tabbars.dart';
import 'provider/app.dart';
import 'provider/factory.dart';
import 'translation/i18n.dart';

///入口函数
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DdTaokeUtil.instance
      .init('https://itbug.shop', '443', proxy: '', debug: false);
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
            title: kAppName,
            translations: I18n(),
            debugShowCheckedModeBanner: false,
            // locale: ui.window.locale,
            locale: const Locale.fromSubtags(languageCode: "en"),
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
