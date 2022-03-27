import 'package:flutter/cupertino.dart';

import '../../../constant/color_constant.dart';

/// 初始化的时候加载状态指示器
class FullScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CupertinoActivityIndicator(),
            SizedBox(height: 12),
            Text(
              '努力加载中~',
              style: TextStyle(color: kTextColor),
            ),
          ],
        ),
      ),
    );
  }
}
