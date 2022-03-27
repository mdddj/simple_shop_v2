import 'package:flutter/cupertino.dart';

import '../../constant/color_constant.dart';

/// 帮助页面
class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('领券帮助'),),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _group('1.复制口令', '01.png'),
              _group('2.打开[手机淘宝]APP,等待弹窗', '02.png'),
              _group('3.点击领券', '03.jpg'),
              _group('4.下单使用折扣', '04.jpg'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _group(String title, String assetImage) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_title(title), _assetImage(assetImage)],
        ),
      ),
    );
  }

  /// 文字
  Widget _title(String title) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 15,
      ),
      child: Text(
        '$title',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: kPrimaryColor),
      ),
    );
  }

  /// 图片
  Widget _assetImage(String name) {
    return ClipRRect(
        borderRadius:
            BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
        child: Image.asset('assets/help/$name'));
  }
}
