import 'package:dataoke_sdk/network/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'controller/app_controller.dart';
import 'provider/factory.dart';
import 'service/app_service.dart';
import 'service/impl/api_service_impl.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

import 'package:get_storage/get_storage.dart';

import 'main_tabbars.dart';

///
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: CupertinoApp(
        title: '梁典典',
        debugShowCheckedModeBanner: false,
        locale: ui.window.locale,
        // theme: ThemeData(
        //     visualDensity: VisualDensity.adaptivePlatformDensity,
        //     appBarTheme: AppBarTheme(backgroundColor: Colors.white,titleTextStyle: TextStyle(color: Colors.black,fontSize: 12),iconTheme: IconThemeData(color: Colors.grey,size: 20),elevation: 0 ),
        //     primaryColor: kPrimaryColor,cardTheme: CardTheme(
        //       elevation: 0
        //     )),
        theme: CupertinoThemeData(
        ),
        home: MainTabbars(),
      ),
    );
  }
}
