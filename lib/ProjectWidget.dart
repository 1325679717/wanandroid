import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_new/bloc/MainBloc.dart';

import 'model/RecommProjectData.dart';
import 'package:flutter_new/widgets/RecommProjectItem.dart';

class ProjectWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final RefreshController _refreshController =
    RefreshController(initialRefresh: false);
    MainBloc bloc = MainBloc();
    bloc.getProjectRefresh();
    bloc.tabProjectStream.listen((event) {
      _refreshController.refreshCompleted();
      _refreshController.loadComplete();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("项目"),
        ),
      ),

      body: StreamBuilder(
          stream: bloc.tabProjectStream,
          builder: (BuildContext context,
              AsyncSnapshot<List<RecommProjectData>?> snapshot){
                  if (snapshot.data == null){
                    return Container();
                  }
                  print("tabProjectStream length = ${snapshot.data!.length}");
                  return SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: const WaterDropHeader(),
                      controller: _refreshController,
                      onRefresh: (){
                        bloc.getProjectRefresh();
                      },
                      onLoading: (){
                        bloc.getProjectLoadMore();
                      },
                      footer: CustomFooter(builder: (BuildContext context, LoadStatus? mode) {
                        Widget body ;
                        if(mode==LoadStatus.idle){
                          body =  Text("pull up load");
                        }
                        else if(mode==LoadStatus.loading){
                          body =  CupertinoActivityIndicator();
                        }
                        else if(mode == LoadStatus.failed){
                          body = Text("Load Failed!Click retry!");
                        }
                        else if(mode == LoadStatus.canLoading){
                          body = Text("release to load more");
                        }
                        else{
                          body = Text("No more Data");
                        }
                        return Container(
                          height: 55.0,
                          child: Center(child:body),
                        );
                      },
                      ),
                      child:ListView.builder(
                        itemBuilder: (context,index){
                          return buildRecommProject(snapshot.data![index],bloc);
                        },
                        itemCount: snapshot.data != null ?snapshot.data?.length : 0,
                      )
                  );

        }),
      );
  }


  Widget buildRecommProject(RecommProjectData data,MainBloc bloc){
    return RecommProjectItem(data,bloc);
  }
}
