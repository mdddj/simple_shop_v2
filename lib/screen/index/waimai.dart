import 'dart:convert';

import 'package:dataoke_sdk/dd_taoke_sdk.dart';
import 'package:dataoke_sdk/params/activity_link_param.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// 领取外卖优惠券
class Waimai extends StatefulWidget {
  const Waimai({Key? key}) : super(key: key);

  @override
  _WaimaiState createState() => _WaimaiState();
}

class _WaimaiState extends State<Waimai> {
//饿了吗外卖券
  Future<void> handleWithElm() async {
    final result = await DdTaokeSdk.instance.getActivityLink(
        ActivityLinkParam(promotionSceneId: '20150318019998877'));
    print('${jsonEncode(result)}');
    if (result != null) {
      final url = result.clickUrl;
      if (await canLaunch(url)) {
        await launch(url);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Row(children: [Container(
        
      ), Container()]),
    );
  }
}
