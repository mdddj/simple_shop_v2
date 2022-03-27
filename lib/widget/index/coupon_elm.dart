import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/app_constant.dart';

// 饿了么优惠券
class CouponElm extends StatelessWidget{
  const CouponElm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        
      },
      child: Container(
        margin: const EdgeInsets.all(kDefaultPadded),
        padding: const EdgeInsets.all(kDefaultPadded* .2),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: const BorderRadius.all(Radius.circular(15))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/image/elm.jpg',width: 50,height: 50,),
            const SizedBox(width: 20,),
            Text('领取饿了么优惠券,每天限领一次 >>',style: Get.textTheme.bodyText1,)
          ],
        ),
      ),
    );
  }

}