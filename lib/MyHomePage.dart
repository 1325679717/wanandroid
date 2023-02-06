import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_new/MeWidget.dart';
import 'package:flutter_new/ProjectWidget.dart';
import 'package:flutter_new/RecommWidget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Widget> tabContent= [RecommWidget(),ProjectWidget(),MeWdget()];
  List<BottomNavigationBarItem> items = [const BottomNavigationBarItem(icon: Icon(Icons.home),label: "主页"),
    const BottomNavigationBarItem(icon: Icon(Icons.list),label: "项目"),
    const BottomNavigationBarItem(icon: Icon(Icons.person),label: "我的")];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: tabContent),

      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index){
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex:  _currentIndex,
        items:items,
      ),
    );
  }
}