import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/utils/navigator_util.dart';
import 'package:flutter_new/widgets/likebtn/like_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebWidget extends StatefulWidget {
  WebWidget(
      this.url,
      this.title,
      {Key? key}) : super(key: key);
  String url;
  String? title;
  @override
  WebState createState() => WebState();

}

class WebState extends State<WebWidget> {
  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) {
    //   WebView.platform = SurfaceAndroidWebView();
    // }

    WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? "")
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) { //控制页面是否进入下页
          if (request.url.startsWith('http://www.yyh.com')) {
            return NavigationDecision.prevent; //禁止跳下页
          }
          return NavigationDecision.navigate; //放行跳下页
        },
        onPageStarted: (String url) {
          print("onPageStarted $url");
        },
        onPageFinished: (String url) {
          print("onPageFinished $url");
        },
        onWebResourceError: (error) {
          print("${error.description}");
        },
      )
    );
  }
}
