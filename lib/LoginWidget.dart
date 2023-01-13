import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/bloc/LoginBloc.dart';
import 'package:flutter_new/res/styles.dart';
import 'package:flutter_new/utils/Constant.dart';
import 'package:flutter_new/utils/LoadingPage.dart';
import 'package:flutter_new/utils/SpUtil.dart';
import 'package:flutter_new/utils/ToastUtil.dart';
import 'package:flutter_new/utils/util_index.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_new/event/EventBusManager.dart';

import 'event/Event.dart';

class LoginWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    LoadingPage loadingPage = LoadingPage(context);
    LoginBloc loginBloc = LoginBloc();
    TextEditingController userNameController = TextEditingController();
    TextEditingController pwdController = TextEditingController();
    String  userName=SpUtil.getString(Constant.keyUserName) ?? "";
    if (userName !=null && userName != ""){
      userNameController.text = userName;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("登录")
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            TextField(
              controller: userNameController,
              decoration: const InputDecoration(
                labelText: "用户名",
              ),
            ),
            Gaps.hGap10,
            TextField(
              controller: pwdController,
              decoration: const InputDecoration(
                labelText: "密码",
              ),
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
            Gaps.hGap10,
            ElevatedButton(
                onPressed: (){
                  if (Utils.stringEmpty(userNameController.text)){
                    ToastUtil.showToast("用户名不能为空！");
                    return;
                  }
                  if (Utils.stringEmpty(pwdController.text)){
                    ToastUtil.showToast("密码不能为空！");
                    return;
                  }

                  loadingPage.show();
                  loginBloc.login(
                      userNameController.text,
                      pwdController.text)
                      .then((value){
                    SpUtil.putString(Constant.keyUserName, userNameController.text);
                    EventBusManager.eventBus.fire(LoginChangeEvent(true));
                    loadingPage.close();

                    ToastUtil.showToast("登录成功！");
                    Navigator.pop(context);
                  }).catchError((error) {
                    print("登录$error");
                    loadingPage.close();
                    ToastUtil.showToast("请求失败啦");
                  });
                },
                child: const Center(
                  child: Text(
                      "登录",
                  style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      )
    );
  }
}