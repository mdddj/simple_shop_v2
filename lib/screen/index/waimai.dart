import 'dart:convert';

import 'package:dataoke_sdk/apis/apis.dart';
import 'package:dataoke_sdk/dd_taoke_sdk.dart';
import 'package:dataoke_sdk/params/activity_link_param.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_more_list/loading_more_list.dart';
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

  //美团外卖券
  Future<void> _meituan() async {
   final api = MeiTuanQuanApi()
      ..actId = '2'
      ..linkType = '1'
      ..miniCode = '1';

   api.request(dataHandle: (map){
      final url =  map['data'];
   });
  }

  Widget _renderItem(
      String svg, String title, String subTitle, VoidCallback onTap) {
    return Container(
      child: Row(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/svg/$svg''.svg',
                width: 30,
                height: 30,
              ),
              Text('$title')
            ],
          ),
          TextButton(onPressed: onTap, child: Text('领券'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverWaterfallFlow.count(
      crossAxisCount: 2,
      children: [
        _renderItem('elm', '饿了吗外卖', '每天都能领一次哦', handleWithElm),
        _renderItem('meituan', '美团外卖', '吃饭前领一次哦', _meituan)
      ],
    );
  }
}
