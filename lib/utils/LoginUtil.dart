import 'Constant.dart';
import 'SpUtil.dart';

class LoginUtil{
  /**
   * 是否已登录
   */
  static bool isLogin(){
    String? token = SpUtil.getString(Constant.keyAppToken);
    if (token != null && token != ""){
      return true;
    }
    return false;
  }
}