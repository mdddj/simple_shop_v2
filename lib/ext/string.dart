import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

extension StringExt on String {

  ///跳转到浏览器
  Future<void> tryLaunch()async{
    if(await canLaunchUrl(Uri.parse(this))){
     await launchUrlString(this);
    }
  }
}