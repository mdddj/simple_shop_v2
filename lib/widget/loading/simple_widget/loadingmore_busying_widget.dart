import 'package:flutter/cupertino.dart';

import '../../../constant/color_constant.dart';


/// 加载下一页指示器
class LoadingMoreBysyingWidget extends StatelessWidget {
  final String? text;

  const LoadingMoreBysyingWidget({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CupertinoActivityIndicator(),
          const SizedBox(
            width: 5,
          ),
          Text(
            text ?? '加载中',
            style: TextStyle(color: kTextColor),
          )
        ],
      ),
    );
  }
}
