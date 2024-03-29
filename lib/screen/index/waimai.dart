import 'package:dataoke_sdk/dataoke_sdk.dart';
import 'package:dd_js_util/api/request_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:url_launcher/url_launcher_string.dart';


/// 领取外卖优惠券
class Waimai extends StatefulWidget {

  ///构造
  const Waimai({Key? key}) : super(key: key);

  @override
  WaimaiState createState() => WaimaiState();
}

class WaimaiState extends State<Waimai> {

  ///饿了吗外卖券
  Future<void> handleWithElm() async {
    final result = await DdTaokeSdk.instance.getActivityLink(
        ActivityLinkParam(promotionSceneId: '20150318019998877'), requestParamsBuilder: (RequestParams requestParams) {
          return requestParams;
    });
    if (result != null) {
      final url = result.clickUrl;
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      }
    }
  }

  //美团外卖券
  Future<void> _meituan() async {
   final api = MeiTuanQuanApi()
      ..actId = '2'
      ..linkType = '1'
      ..miniCode = '1';

   api.request();
  }

  Widget _renderItem(
      String svg, String title, String subTitle, VoidCallback onTap) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
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
              const SizedBox(width: 6,),
              Text(title)
            ],
          ),
          const Spacer(),
          TextButton(onPressed: onTap, child: const Text('领券'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      sliver: SliverWaterfallFlow.count(
        crossAxisCount: 2,
        children: [
          _renderItem('elm', '饿了吗外卖', '每天都能领一次哦', handleWithElm),
          _renderItem('meituan', '美团外卖', '吃饭前领一次哦', _meituan)
        ],
      ),
    );
  }
}
