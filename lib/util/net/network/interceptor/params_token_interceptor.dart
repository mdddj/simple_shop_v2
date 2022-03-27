
import 'package:dio/dio.dart';

import '../http_request.dart';

/// 参数拦截器
class ParamsTokenInterceptor extends Interceptor{

  final String token;
  ParamsTokenInterceptor(this.token);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[HttpRequest.PARAMS_HEADER_KEY] = token;
    super.onRequest(options, handler);
  }
}