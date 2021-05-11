import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

/// 活动页面
class TaobaoActivityPage extends StatefulWidget {
  final String activityId; // 活动id
  final String title; // 活动名字

  const TaobaoActivityPage({Key? key, required this.activityId,required this.title})
      : super(key: key);

  @override
  _TaobaoActivityPageState createState() => _TaobaoActivityPageState();
}

class _TaobaoActivityPageState extends State<TaobaoActivityPage> {
  final TaobaoActivityLogic logic = Get.put(TaobaoActivityLogic());

  @override
  void initState() {
    logic.init(widget.activityId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text( widget.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx((){
              if(logic.activityLinks.value!=null){
                return Text('${jsonEncode(logic.activityLinks.value!)}');
              }
              return Text('');
            })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<TaobaoActivityLogic>();
    super.dispose();
  }
}
