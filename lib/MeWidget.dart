import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_new/LoginWidget.dart';
import 'package:flutter_new/utils/Constant.dart';
import 'package:flutter_new/utils/LoginUtil.dart';
import 'package:flutter_new/utils/SpUtil.dart';
import 'package:flutter_new/utils/navigator_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MeWdget extends StatefulWidget {
  @override
  State<MeWdget> createState() => _MeWdgetState();
}

class _MeWdgetState extends State<MeWdget> {
  @override
  Widget build(BuildContext context) {
    String text = "退出";
    if (!LoginUtil.isLogin()){
      text = "去登录";
    }
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("我的"),
        ),
      ),
      body: Center(
        child: Center(
              child: ElevatedButton(
                  onPressed: (){
                    if(!LoginUtil.isLogin()) {
                        NavigatorUtil.pushPage(context, LoginWidget(), pageName: "MeWidget");
                      return;
                    }
                    SpUtil.putString(Constant.keyAppToken, "");
                    Fluttertoast.showToast(
                        msg: "已退出登录！",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.white38,
                        textColor: Colors.black,
                        fontSize: 16.0
                    );
                    setState(() {});
                  },
                  child: Center(
                    child: Text(text),
                  )),
        ),
      ),
    );
  }
}
