


import 'package:get/get.dart';

/// 不为空
bool isNull(dynamic value){
  if(value==null) return true;
  return GetUtils.isNullOrBlank(value);
}