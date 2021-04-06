

import 'package:dd_taoke_sdk/model/category.dart';

/// 服务器错误消息
typedef ServerError = void Function(int code,String message);

/// 超级分类选中
typedef CategorySelectd = void Function(int index,Category item);