import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikeBtn extends StatelessWidget {
  const LikeBtn({
    Key? key,
    required this.id,
    required this.isLike,
    this.onTap
  }) : super(key: key);
  final int id;
  final bool isLike;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Icon(
        Icons.favorite,
        color: (isLike == true)
            ? Colors.redAccent
            : Colors.grey,
      ),
    );
  }
}