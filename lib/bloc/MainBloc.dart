  import 'package:flutter_new/model/BannerData.dart';
import 'package:flutter_new/model/CollectData.dart';
import 'package:flutter_new/repository/wan_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../model/ArticleData.dart';
import '../model/RecommProjectData.dart';

class MainBloc{

  WanRepository wanRepository = WanRepository();

  /**
   * banner
   */
  BehaviorSubject<List<BannerData>> banner = BehaviorSubject<List<BannerData>>();
  Sink<List<BannerData>?> get bannerSink => banner.sink;
  Stream<List<BannerData>?> get bannerStream => banner.stream;

  /**
   * 推荐项目
   */
  BehaviorSubject<List<RecommProjectData>> project = BehaviorSubject<List<RecommProjectData>>();
  Sink<List<RecommProjectData>?> get projectSink => project.sink;
  Stream<List<RecommProjectData>?> get projectStream => project.stream;
  /**
   * 推荐公众号
   */
  BehaviorSubject<List<ArticleData>> article = BehaviorSubject<List<ArticleData>>();
  Sink<List<ArticleData>?> get articleSink => article.sink;
  Stream<List<ArticleData>?> get articleStream => article.stream;
  /**
   * 收藏/取消
   */
  BehaviorSubject<CollectData> collectSubject = BehaviorSubject<CollectData>();
  Sink<CollectData?> get collectSink => collectSubject.sink;
  Stream<CollectData> get collectStream => collectSubject.stream;

  BehaviorSubject<List<RecommProjectData>> tabProject = BehaviorSubject<List<RecommProjectData>>();
  Sink<List<RecommProjectData>?> get tabProjectSink => tabProject.sink;
  Stream<List<RecommProjectData>?> get tabProjectStream => tabProject.stream;
  int _projectPage = 0;
  List<RecommProjectData> projectList =[];

  Future<CollectData?> collect(int id,bool isLike){
    if (isLike){
      return wanRepository.unCollect(id).then((value){
        if(value == true) {
          collectSink.add(CollectData(id, false));
        }
      });
    }else {
      return wanRepository.collect(id).then((value) {
        collectSink.add(CollectData(id, value));
      });
    }
  }
  Future<List<ArticleData>?> getArticle(){
    return wanRepository.getArticle().then((value){
      articleSink.add(value);
    });
  }

  Future<List<RecommProjectData>?> getProject(){
    return wanRepository.getProject().then((value){
      projectSink.add(value);
    });
  }

  Future<List<BannerData>?> getBanner(){
    return wanRepository.getBanner().then((value){
      bannerSink.add(value);
    });
  }

  Future<List<RecommProjectData>?> getProjectRefresh(){
    _projectPage = 0;
    projectList.clear();
    return wanRepository.getProjectData(_projectPage).then((value){
      if (value != null) {
        projectList.clear();
        projectList.addAll(value);
      }
      tabProjectSink.add(projectList);
    });
  }
  Future<List<RecommProjectData>?> getProjectLoadMore(){
    _projectPage++;
    return wanRepository.getProjectData(_projectPage).then((value){
      if (value != null) {
        projectList.addAll(value);
      }
      tabProjectSink.add(projectList);
    }).catchError((onError){
      _projectPage--;
    });
  }
}