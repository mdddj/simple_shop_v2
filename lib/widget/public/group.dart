import '../../constant/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Group extends StatelessWidget {
  final Widget? body;
  final String? title;
  final bool showTitle;

  const Group({Key? key, this.body, this.title, this.showTitle = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.symmetric(
          horizontal: kDefaultPadded, vertical: kDefaultPadded / 3),
      padding: EdgeInsets.all(kDefaultPadded / 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showTitle)
            Padding(
              padding: EdgeInsets.symmetric(vertical: kDefaultPadded / 2),
              child: Text(
                '$title',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          body!
        ],
      ),
    );
  }
}
