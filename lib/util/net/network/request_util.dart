import 'dart:convert';
import 'request_params_util.dart';
import 'package:get/get.dart';

import 'aes_util.dart';

/// 加密请求工具类
class RequestUtil{

  /// 对参数进行加密发送给服务器
  /// [params] 请求参数
  /// 返回处理加工的数据
  /// 提交服务器的原始数据
  static ServerEncryptionData handleParams(Map<String, String?> params,{bool showLog=false}){
    var newParams = RequestParamsUtils.keySort(params);
    var paramsToken = RequestParamsUtils.generateToken(newParams);
    var data = AesUtil.encryptAESCbc128WithPadding7(base64Encode(utf8.encode(json.encode(newParams))));
    // print("-----------------------------------------参数&MD5-------------------------------------");
    params.keys.forEach((element) {
      // print("$element = ${params[element]}");
    });
    // print(paramsToken);
    // print("---------------------------------------------------------------------------------");
    if(showLog){
      Get.log('params_token=[$paramsToken],data=$data');
    }
    //Get.log('[DEBUG] - 请求参数[data],值:[$data]');
    return ServerEncryptionData(paramsToken, data);
  }
}

/// 封装
class ServerEncryptionData{
  String paramsToken;
  String  data;
  ServerEncryptionData(this.paramsToken,this.data);
}