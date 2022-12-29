import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/bloc/LoginBloc.dart';
import 'package:flutter_new/res/styles.dart';
import 'package:flutter_new/utils/LoadingPage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    LoadingPage loadingPage = LoadingPage(context);
    LoginBloc loginBloc = LoginBloc();
    TextEditingController userNameController = TextEditingController();
    TextEditingController pwdController = TextEditingController();
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
                  loadingPage.show();
                  loginBloc.login(
                      userNameController.text,
                      pwdController.text)
                      .then((value){
                    loadingPage.close();
                    Fluttertoast.showToast(
                        msg: "登录成功！",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.white38,
                        textColor: Colors.black,
                        fontSize: 16.0
                    );
                    Navigator.pop(context);
                  }).catchError((error) {
                    print("登录$error");
                    loadingPage.close();
                    Fluttertoast.showToast(
                        msg: "请求失败啦",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.white38,
                        textColor: Colors.black,
                        fontSize: 16.0
                    );
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