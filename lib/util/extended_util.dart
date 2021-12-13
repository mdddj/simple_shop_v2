// 工具类
import 'dart:developer';

import '../constant/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  Utils._();

  static final Utils _instace = Utils._();

  factory Utils() => _instace;

  //处理图片不带http
  String imageHeaderHandle(String url) {
    if (url.indexOf('//') == 0) {
      return 'https:$url';
    }
    return url;
  }

  // 请求参数
  Map<String, String?> initParamsMap() {
    return <String, String?>{};
  }

  // 复制
  void copy(String? text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  // 打开淘宝
  Future<void> openTaobao(String url) async {
    var _url = url;
    if (_url.indexOf('http://') == 0) {
      _url = _url.replaceAll('http://', '');
    } else if (_url.indexOf('https://') == 0) {
      _url = _url.replaceAll('https://', '');
    }
    _url = 'taobao://' + _url;
    log('打开url:$_url');
    if (await canLaunch(_url)) {
      // 判断当前手机是否安装某app. 能否正常跳转
      await launch(_url);
    } else {
      await Get.dialog(AlertDialog(
        title: Text('打开淘宝APP失败'),
        content: Text('请检查是否安装淘宝APP'),
      ));
    }
  }

  // 日期转换
  DateTime? getTime(String val, Map<String, dynamic> json) {
    if (val.toString().isNotEmpty &&
        json[val] != null &&
        json[val].toString().isNotEmpty) {
      return DateTime.parse(json[val]);
    }
    return null;
  }
}

extension StringUtil on String {
  String imageUrl() {
    return Utils().imageHeaderHandle(this);
  }

  /// 在字符串前面添加人民币符号
  String get coverRmbPrice => '$rmb $this';

  /// 跳转到浏览器
  Future<void> launchUrl() async {
    if(await canLaunch(this)){
    await launch(this);
    }
  }
}



extension DoubleUtil on double? {
  String toRMB() {
    return '$rmb $this';
  }
}
