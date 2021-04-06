import 'dart:developer';

import 'package:dd_tk_shop/functions/fun_type.dart';
import 'package:dd_tk_shop/util/net/network/request_util.dart';
import 'package:dd_tk_shop/util/net/network/result_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;

import 'aes_util.dart';
import 'dio_errors.dart';
import 'interceptor/params_token_interceptor.dart';

/// 典典的小卖部
/// 网络请求工具封装
/// v2
/// 2020-12-1 14:11:37
///
class HttpRequest {

  HttpRequest._internal();

  static final HttpRequest _instance = HttpRequest._internal();

  factory HttpRequest() => _instance;

  static void init(){
    createInstance();
  }

  static Dio dio;

  // static const String HOST = "http://itbug.shop:8088/tkapi";

  static const String HOST = "http://192.168.43.185:8088/tkapi";

  /// 网络请求超时时间 10秒
  /// 注意超过十秒钟服务器可能不会 返回正确数据!
  /// timeToken 如果超过十秒钟系统认定此次请求非法操作
  /// 返回示例:
  /// {
  ///     "state": 500,
  ///     "message": "非法操作:请求超时",
  ///     "data": null
  /// }
  static const int TIMEOUT = 10000;

  /// get 请求
  static const String GET = "get";

  /// post 请求
  static const String POST = "post";

  /// 不能改
  /// 固定值
  /// 服务器如果查不到这个header值
  /// 将返回非法操作提示
  /// 返回示例
  /// (同上) 非法操作,缺少参数
  static const String PARAMS_HEADER_KEY = "params_token";

  /// 参数key
  /// 值是aes字符串
  static const String DATA_KEY = "data";

  /// 请求成功code
  static const int SUCCESS_CODE = 200;

  /// 发起一个网络请求
  /// [url] 接口地址. (require)
  /// [data] 参数. 列子:{"id":"10553823"}
  /// [method] 请求方法.
  static Future<String> req(String url,
      {Map<String, String> data, String method, ServerError onError,bool showLog=false}) async {
    /// 请求前的准备
    method = method ?? GET;
    onError = onError ?? serverErrorDefaultHandle;
    data = data ?? Map<String, String>();
    ServerEncryptionData serverEncryptionData = RequestUtil.handleParams(data,showLog: showLog);
    dio.interceptors
        .add(ParamsTokenInterceptor(serverEncryptionData.paramsToken));

    /// 准备完成

    /// 开始请求数据
    Response response;

    try {
      switch (method) {
        case GET:
          // print(url);
          response = await dio.request(url,
              queryParameters: {DATA_KEY: serverEncryptionData.data},
              options: Options(method: GET));
          break;
        case POST:
          response = await dio.request(url,
              data: {DATA_KEY: serverEncryptionData.data},
              options: Options(method: POST));
          break;
        default:
          break;
      }
      if (response != null) {
        Result result = Result.fromJson(response.data);
        if (result.state == SUCCESS_CODE) {
          String data = AesUtil.aesDecrypt(result.data);
          if(showLog){
            log("$url返回:$data");
          }
          return data;
        } else {
          onError(result.state, result.message);
        }
      }
    } on DioError catch (e) {
      ErrorEntity en = new ErrorEntity().createErrorEntity(e);
      print("dio请求出错:[${en.code}],错误信息:${en.message},接口:$url");
      return "";
    }
    return "";
  }

  /// 创建dio实例
  static Dio createInstance() {
    if (dio == null) {
      BaseOptions options = BaseOptions(baseUrl: HOST, connectTimeout: TIMEOUT);
      dio = Dio(options);
      Get.log('初始化Api接口成功. 服务器HOST===>[$HOST]');
    }
    return dio;
  }
}

/// 默认错误处理
/// 这里只打印了一下服务器返回的报错信息
void serverErrorDefaultHandle(int code, String message) {
  Get.log('服务器没有返回正确数据.errorCode:$code,errorMessage:$message',isError:true);
}
