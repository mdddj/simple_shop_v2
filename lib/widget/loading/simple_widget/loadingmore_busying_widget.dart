import '../../../constant/color_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


/// 加载下一页指示器
class LoadingMoreBysyingWidget extends StatelessWidget {
  final String? text;

  const LoadingMoreBysyingWidget({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CupertinoActivityIndicator(),
          SizedBox(
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
