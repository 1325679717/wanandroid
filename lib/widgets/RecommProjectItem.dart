import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/LoginWidget.dart';
import 'package:flutter_new/bloc/MainBloc.dart';
import 'package:flutter_new/model/CollectData.dart';
import 'package:flutter_new/res/dimens.dart';
import 'package:flutter_new/utils/LoginUtil.dart';
import 'package:flutter_new/widgets/likebtn/like_button.dart';
import 'package:flutter_new/widgets/widget_util.dart';

import '../model/RecommProjectData.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import '../utils/navigator_util.dart';
import '../utils/timeline_util.dart';
import '../utils/utils.dart';

class RecommProjectItem extends StatefulWidget{
  RecommProjectItem(
      this.data,
      this.bloc
      );
  final RecommProjectData data;
  final MainBloc bloc;

  @override
  State<RecommProjectItem> createState() => _RecommProjectItemState();
}
class _RecommProjectItemState extends State<RecommProjectItem> {
  @override
  Widget build(BuildContext context) {
    widget.bloc.collectStream.listen((collectData) {
      if (widget.data.id == collectData.id
          && mounted){
          setState(() {
            widget.data.collect = collectData.isLike;
          });
      }
    });
    bool isLogin = LoginUtil.isLogin();
    bool collect = false;
    if (isLogin){
      collect = widget.data.collect ?? false;
    }
    return InkWell(
      onTap: (){
        NavigatorUtil.pushWeb(context,title: widget.data.title,url: widget.data.link);
      },
      child: Container(
          height: 160,
          padding: const EdgeInsets.only(top: Dimens.gap_dp16,left: Dimens.gap_dp16),
          decoration:  const BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom:BorderSide(width: 0.33, color: Colours.divider)
              )
          ),
          child: Row(
              children: [
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.title ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                        Gaps.vGap10,
                        Expanded(child: Text(
                          maxLines: 3,
                          widget.data.desc ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.grey),
                        )),
                        Padding(
                          padding: const EdgeInsets.only(top: Dimens.gap_dp16,bottom: Dimens.gap_dp10),
                          child: Row(
                            children: [
                              LikeBtn(isLike: collect,
                                  id: widget.data.id ?? -1,
                                  onTap: (){
                                    if (LoginUtil.isLogin()) {
                                      widget.bloc.collect(
                                          widget.data.id ?? -1, widget.data.collect ?? false);
                                    }else {
                                      NavigatorUtil.pushPage(context, LoginWidget(), pageName: "login");
                                    }

                                  } //NavigatorUtil.pushPage(context, LoginWidget(), pageName: "login"),
                              ),
                              Gaps.hGap10,
                              Text(widget.data.author ?? ""),
                              Gaps.hGap10,
                              Text(Utils.getTimeLine(context,widget.data.publishTime ?? 0))
                            ],
                          ),)

                      ],

                    )),
                Container(
                  width: 72,
                  padding: const EdgeInsets.only(right: Dimens.gap_dp16),
                  child: Image(
                    height: 128,
                    width: 72,
                    fit: BoxFit.fill,
                    image: NetworkImage(widget.data.envelopePic ?? ""),
                  ),
                )
              ])
      ),
    );
  }
}