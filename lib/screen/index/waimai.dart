import 'dart:convert';

import 'package:dd_taoke_sdk/dd_taoke_sdk.dart';
import 'package:dd_taoke_sdk/params/activity_link_param.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// 领取外卖优惠券
class Waimai extends StatefulWidget {
  const Waimai({Key? key}) : super(key: key);

  @override
  _WaimaiState createState() => _WaimaiState();
}

class _WaimaiState extends State<Waimai> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: ElevatedButton(
        onPressed: () async{

          // await Get.dialog(AlertDialog(
          //   title: Text('领取饿了么外卖券'),
          //   content: SingleChildScrollView(
          //     child: Column(
          //       children: [
          //         TextButton(onPressed: (){}, child: Text('使用微信领取'))
          //       ],
          //     ),
          //   ),
          // ));

         final result  = await DdTaokeSdk.instance.getActivityLink(ActivityLinkParam(promotionSceneId: '20150318019998877'));
         print('${jsonEncode(result)}');
         if(result!=null){
           final url = result.clickUrl;
           if(await canLaunch(url)){
             await launch(url);
           }
         }
        },
        child: Text('领取外卖优惠券(每天只能领一次)'),
      ),
    );
  }
}
