import 'package:get/get.dart';

class I18n extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'zh_CN':{
      '典典的小卖部':'典典的小卖部',
      '美食':'美食'
    },
    'en_US':{
      '典典的小卖部':'典典\'s Canteen ',
      '美食':'fine food '
    }
  };

}