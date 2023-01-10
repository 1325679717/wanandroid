import 'package:flutter/cupertino.dart';

class MeItemData{
  String id;
  String title;
  IconData iconData;
  Widget? widget;

  MeItemData(this.id,this.title, this.iconData,{this.widget});
}