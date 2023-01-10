import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return AboutState();
  }
}
class AboutState extends State<AboutWidget>{
  final BasicMessageChannel<String> _basicMessageChannel =
  const BasicMessageChannel("BasicMessageChannelPlugin", StringCodec());
  String _content = "暂无内容";
  String _resultContent = "暂无内容";
  @override
  void initState() {
    _basicMessageChannel.setMessageHandler((message) => Future<String>(() {
      print(message);
      //message为native传递的数据
      setState(() {
        _content = message!;
      });
      //给Android端的返回值
      return "收到Native消息：${message!}";
    }));
    super.initState();
  }

  //向native发送消息
  void _sendToNative() {
    Future<String?> future = _basicMessageChannel.send("我是flutter");
    future.then((message) {
      setState(() {
        _resultContent = "返回值：${message!}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("关于"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              InkWell(
                child: Text("发送"),
                onTap: ()=> _sendToNative(),
              ),
              Text(_content),
              Text(_resultContent)
            ],
          ),
        ),
      ),
    );
  }

}