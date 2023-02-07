
import 'package:flutter/material.dart';
import 'package:flutter_new/MyHomePage.dart';
import 'package:flutter_new/notifier/LoginNotifier.dart';
import 'package:flutter_new/utils/SpUtil.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  runApp(ChangeNotifierProvider(
      create: (context) => LoginNotifier(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
