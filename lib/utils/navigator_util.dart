import 'package:flutter/cupertino.dart';
import 'package:flutter_new/WebWidget.dart';
import 'package:flutter_new/utils/utils.dart';

class NavigatorUtil {
  static void pushPage(
      BuildContext context,
      Widget? page, {
        required String pageName,
        bool needLogin = false,
      }) {
    if (context == null || page == null) return;
/*    if (needLogin && !Utils.isNeedLogin()) {
      // pushPage(context, UserLoginPage());
      return;
    }*/
    Navigator.push(
        context, CupertinoPageRoute<void>(builder: (ctx) => page));
  }
  static void pushWeb(BuildContext context,
      {String? title, String? url}) {
    if (context == null || url == null || url == "") return;
    Navigator.push(
        context,
        CupertinoPageRoute<void>(
            builder: (ctx) => WebWidget(
              url,
              title,
            )));
  }

}
