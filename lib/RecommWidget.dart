import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_new/bloc/MainBloc.dart';
import 'package:flutter_new/widgets/HeaderItem.dart';
import 'package:flutter_new/widgets/RecommArticleItem.dart';
import 'package:flutter_new/widgets/RecommProjectItem.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'model/ArticleData.dart';
import 'model/BannerData.dart';
import 'model/RecommProjectData.dart';

class RecommWidget extends StatelessWidget{

  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  MainBloc bloc = MainBloc();
  void refreshCompleted(){
    _refreshController.refreshCompleted();
    // Future.delayed(const Duration(milliseconds: 200),(){
    //   _refreshController.refreshCompleted();
    // });
  }
  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("推荐"),
        ),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: const WaterDropHeader(),
        controller: _refreshController,
        onRefresh: (){
          loadData();
        },
        child: ListView(
          children: [
            StreamBuilder(
                stream: bloc.bannerStream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<BannerData>?> snapshot){
                  return buildBanner(snapshot);
                }
            ),
            HeaderItem(
                title: "推荐项目",
                leftIcon: Icons.book,
                rightIcon : Icons.keyboard_arrow_right,
                onTap: ()=> print("推荐项目")),
            StreamBuilder(
                stream: bloc.projectStream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<RecommProjectData>?> snapshot){
                  if (snapshot.data == null){
                    return Container();
                  }
                  return buildRecommProject(snapshot,bloc);
                }
            ),
            HeaderItem(
                color: Colors.green,
                title: "推荐公众号",
                leftIcon: Icons.library_books,
                rightIcon : Icons.keyboard_arrow_right,
                onTap: ()=> print("推荐公众号")),
            StreamBuilder(
                stream: bloc.articleStream,
                builder: (BuildContext context,
                    AsyncSnapshot<List<ArticleData>?> snapshot){
                  if (snapshot.data == null){
                    return Container();
                  }
                  return buildRecommArticle(snapshot,bloc);
                }
            )
          ],
        ),
      ),
    );
  }
  Widget buildBanner(AsyncSnapshot<List<BannerData>?> snapshot){

    if (snapshot.data == null){
      return AspectRatio(aspectRatio: 16.0/9.0,
          child: Container()
          );
    }
    return AspectRatio(aspectRatio: 16.0/9.0,
        child: PageView(
          children: snapshot.data!.map((e) =>
              InkWell(
                child: Image(
                    image: NetworkImage(e.imagePath ?? "")
                ),
                onTap: ()=> print(e.title),
              )).toList()


          // snapshot.data.map((e) => null)
        ));
  }

  Widget buildRecommArticle(AsyncSnapshot<List<ArticleData>?> snapshot,MainBloc bloc){
    if (snapshot.data == null) return Container();
    return Column(
        children: snapshot.data!.map((e) => RecommArticleItem(e,bloc)).toList()
    );
  }
  Widget buildRecommProject(AsyncSnapshot<List<RecommProjectData>?> snapshot,MainBloc bloc){
    if (snapshot.data == null) return Container();
    return Column(
      children: snapshot.data!.map((e) => RecommProjectItem(e,bloc)).toList()
    );
  }
  void loadData(){
    bloc.getBanner();
    bloc.getProject();
    bloc.getArticle();
    bloc.bannerStream.listen((event) {
        _refreshController.refreshCompleted();
    });
  }
}
