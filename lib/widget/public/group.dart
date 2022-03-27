import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_constant.dart';

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
      margin: const EdgeInsets.symmetric(
          horizontal: kDefaultPadded, vertical: kDefaultPadded / 3),
      padding: const EdgeInsets.all(kDefaultPadded / 2),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showTitle)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPadded / 2),
              child: Text(
                '$title',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          body!
        ],
      ),
    );
  }
}
