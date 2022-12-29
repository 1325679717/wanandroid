import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderItem extends StatelessWidget{
  HeaderItem(
      {required this.title,
       required this.leftIcon,
       required this.rightIcon,
       required this.onTap,
       this.color,
      Key? key})
      :super(key :key);
  final String title;
  final Color? color;
  final IconData leftIcon;
  final IconData rightIcon;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16,right: 16),
              child: Icon(
                  leftIcon ?? Icons.h_mobiledata,
                  color : color ?? Colors.blueAccent
              ),
            ),
            Expanded(
                child: Text(
                    title,
                    style: TextStyle(color : color ?? Colors.blueAccent)
                )
            ),
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                  rightIcon
              ),
            )
          ],
        ),
      ),
    );
  }
}