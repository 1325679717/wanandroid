import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/res/dimens.dart';
import 'package:flutter_new/widgets/likebtn/like_button.dart';
import 'package:flutter_new/widgets/widget_util.dart';

import '../LoginWidget.dart';
import '../bloc/MainBloc.dart';
import '../model/ArticleData.dart';
import '../model/RecommProjectData.dart';
import '../res/colors.dart';
import '../res/styles.dart';
import '../utils/LoginUtil.dart';
import '../utils/navigator_util.dart';
import '../utils/timeline_util.dart';
import '../utils/utils.dart';

class RecommArticleItem extends StatefulWidget{
  RecommArticleItem(
      this.data,
      this.bloc
      );
  final ArticleData data;
  final MainBloc bloc;

  @override
  State<RecommArticleItem> createState() => _RecommArticleItemState();
}

class _RecommArticleItemState extends State<RecommArticleItem> {

  @override
  Widget build(BuildContext context) {

    bool isLogin = LoginUtil.isLogin();
    bool collect = false;
    if (isLogin){
      collect = widget.data.collect ?? false;
    }

    widget.bloc.collectStream.listen((collectData) {
      if (widget.data.id == collectData.id
      && mounted){
        setState(() {
          widget.data.collect = collectData.isLike;
        });
      }
    });
    return InkWell(
      onTap: (){
        NavigatorUtil.pushWeb(context,title: widget.data.title,url: widget.data.link);
      },
      child: Container(
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
                                },),
                              Gaps.hGap10,
                              Text(widget.data.author ?? ""),
                              Gaps.hGap10,
                              Text(Utils.getTimeLine(context,widget.data.publishTime ?? 0))
                            ],
                          ),)

                      ],

                    )),
                Container(
                  padding: const EdgeInsets.only(right: Dimens.gap_dp16),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.green,
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(widget.data.superChapterName??"",
                          textAlign:TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 11.0)
                      ),
                    ),
                  ),
                )
              ])
      ),
    );
  }
}