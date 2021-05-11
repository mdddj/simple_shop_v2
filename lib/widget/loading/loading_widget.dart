import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingWidget extends StatelessWidget {

  final AppBar? appBar;

  const LoadingWidget({Key? key, this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !GetUtils.isNull(appBar) ? appBar : AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
