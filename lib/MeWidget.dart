import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_new/LoginWidget.dart';
import 'package:flutter_new/res/strings.dart';
import 'package:flutter_new/res/styles.dart';
import 'package:flutter_new/utils/Constant.dart';
import 'package:flutter_new/utils/LoginUtil.dart';
import 'package:flutter_new/utils/SpUtil.dart';
import 'package:flutter_new/utils/navigator_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_new/event/EventBusManager.dart';
import 'package:flutter_new/model/MeItemData.dart';

import 'event/Event.dart';
import 'package:flutter_new/res/dimens.dart';
import 'package:flutter_new/res/styles.dart';

class MeWdget extends StatefulWidget {
  @override
  State<MeWdget> createState() => _MeWdgetState();
}

class _MeWdgetState extends State<MeWdget> {
  List<MeItemData>  list =[];
  MeItemData logoutData =MeItemData(Ids.titleSignOut,"注销", Icons.power_settings_new);
  @override
  Widget build(BuildContext context) {
    EventBusManager.eventBus.on<LoginChangeEvent>().listen((event) {
      print("收到登录成功的event =  ${event.isLogin}");
      setState(() {});
    });
    list.clear();
    list.add(MeItemData(Ids.titleCollection,"收藏", Icons.collections));
    list.add(MeItemData(Ids.titleAbout,"关于", Icons.info));
    list.add(logoutData);
    if (!LoginUtil.isLogin()){
      list.remove(logoutData);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("我的"),
        ),
      ),
      body: buildList()
    );
  }
  Widget buildList(){
    return ListView.builder(itemBuilder: (BuildContext context, int index){
      return ListTile(
            title: Container(
              padding: EdgeInsets.only(left: Dimens.gap_dp10),
              child: Row(
                children: [
                  Icon(
                    list[index].iconData
                  ),
                  Gaps.hGap10,
                  Text(list[index].title)
                ],
              ),
            ),
        onTap: (){
          if (list[index].id == Ids.titleSignOut){
            _showLoginOutDialog(context);
          }
        },
      );
    },
      itemCount: list.length,
    );
  }
  void _showLoginOutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: Text(
              "确定退出吗？",
            ),
            actions: <Widget>[
              ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0
                ),
                child: Text(
                  "取消",
                  style: TextStyles.listExtra2,
                ),
                onPressed: () {
                  Navigator.pop(ctx);
                },
              ),
              ElevatedButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0
                ),
                child: Text(
                  "确定",
                  style: TextStyles.listExtra,
                ),
                onPressed: () {
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
              ),
            ],
          );
        });
  }
}
