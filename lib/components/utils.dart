import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../util/api/apis.dart';

/// 工具类
class Utils {
  Api get api => GetIt.instance.get<Api>();

  /// 显示一条消息
  void showMessage(String msg) {
    final _context = Get.context;
    if (_context != null) {
      ScaffoldMessenger.of(_context).removeCurrentSnackBar();
      ScaffoldMessenger.of(_context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  ///处理图片不带http
  String imageHeaderHandle(String url) {
    if (url.indexOf('//') == 0) {
      return 'https:$url';
    }
    return url;
  }

  /// 复制
  void copy(String? text, {String? message}) {
    Clipboard.setData(ClipboardData(text: text));
    showMessage(message ?? '复制成功');
  }

  Future<void> navToBrowser(String url) async {
    if (await canLaunchUrlString(url)) {
      // 判断当前手机是否安装某app. 能否正常跳转
      await launchUrlString(url);
    } else {
      copy(url, message: '跳转url失败,链接已复制到剪贴板');
    }
  }

  /// 跳转到浏览器
  Future<void> openLink(String url, {String urlYs = ''}) async {
    await urlToApp(url, urlYs);
  }

  /// url 跳转到 app  使用约束
  Future<void> urlToApp(String url, String urlYs) async {
    /// 如果是windows平台,直接跳转到浏览器打开链接
    if (GetPlatform.isWindows) {
      await launchUrlString(url);
      return;
    }
    var _url = url;
    _url = '$urlYs${urlHandle(url)}';
    if (await canLaunchUrlString(_url)) {
      // 判断当前手机是否安装某app. 能否正常跳转
      await launchUrlString(_url);
    } else {
      await launchUrlString(url);
    }
  }

  // 打开淘宝
  Future<void> openTaobao(String url) async {
    await urlToApp(url, 'taobao://');
  }

  String urlHandle(String url) {
    var _url = url;
    if (_url.indexOf('http://') == 0) {
      _url = _url.replaceAll('http://', '');
    } else if (_url.indexOf('https://') == 0) {
      _url = _url.replaceAll('https://', '');
    }
    return _url;
  }
}

Utils get utils => GetIt.instance.get<Utils>();

void showToast(String text) {
  utils.showMessage(text);
}
