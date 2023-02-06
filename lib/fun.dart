import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/utils/ToastUtil.dart';
import 'package:flutter_new/widgets/customcheck/CustomCheck.dart';

class FunWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FunState();
  }

}
class FunState extends State<FunWidget>{
  bool _value =true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("玩一玩"),
      ),
      body: Container(
        child: SizedBox(
          width: 100,
          height: 100,
          child: CustomCheckbox(
            value: _value,
            onChanged: (bool? value) {
              setState(() {
                _value = value ?? false;
              });
              ToastUtil.showToast(value.toString());
            },
          ),
        ),
      ),
    );
  }

}