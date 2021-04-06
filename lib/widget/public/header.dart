import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {

  final String title;

  const Header({Key key,@required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(' — $title —',style: Get.textTheme.headline6.copyWith(fontSize: 14),),
    );
  }
}
