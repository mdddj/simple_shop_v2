mixin ApiInterface {
  /// 接口请求没有正常返回数据
  /// [code] 错误代码
  /// [message] 错误消息提示
  void onApiError(int? code, String? message);
}
