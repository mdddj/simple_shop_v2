import 'package:flutter/cupertino.dart';

/// 加载中状态的小部件
class LoadingWidget extends StatelessWidget {

  ///导航条
  final CupertinoNavigationBar? appBar;

  ///构造
  const LoadingWidget({Key? key, this.appBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: appBar,
      child: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
