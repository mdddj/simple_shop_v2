import 'package:get/get.dart';

class I18n extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'zh_CN':{
      '美食':'美食'
    },
    'en_US':{
      '美食':'fine food '
    }
  };

}