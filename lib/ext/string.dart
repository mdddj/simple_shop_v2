import 'package:url_launcher/url_launcher.dart';

extension StringExt on String {

  ///跳转到浏览器
  Future<void> tryLaunch()async{
    if(await canLaunch(this)){
     await launch(this);
    }
  }
}