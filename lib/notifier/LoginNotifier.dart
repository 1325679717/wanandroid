import 'package:flutter/cupertino.dart';

class LoginNotifier extends ChangeNotifier{
  bool _isLogin = false;
  bool get haveLogin{
    return _isLogin;
  }
  void change(bool isLogin){
    _isLogin = isLogin;
    notifyListeners();
  }
}