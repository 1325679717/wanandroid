import 'package:dio/dio.dart';

class RejectInterceptor extends InterceptorsWrapper{
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    handler.reject(err);
  }
}