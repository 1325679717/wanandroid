import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_new/model/BannerData.dart';
import 'package:flutter_new/utils/utils.dart';

import '../dio/dio_method.dart';
import '../dio/dio_response.dart';
import '../dio/dio_util.dart';
import '../model/ArticleData.dart';
import '../model/BaseResp.dart';
import '../model/RecommProjectData.dart';
import '../model/UserData.dart';
import '../utils/Constant.dart';
import '../utils/SpUtil.dart';

class WanRepository {
  /**
   * banner
   */
  Future<List<BannerData>?> getBanner() async {
    DioUtil.getInstance()?.openLog();
    // DioUtil.CACHE_ENABLE = true;
    // DioUtil().setProxy(proxyAddress: "https://www.baidu.com", enable: true)
    DioResponse baseResp = await DioUtil().request("/banner/json", method: DioMethod.get);

    if (baseResp.errorCode != DioResponseCode.SUCCESS) {
       return Future.error(Exception(baseResp.errorMsg));
    }

    BannerArray bannerArray = BannerArray.fromJson(baseResp.data);
    return bannerArray.data;
  }

  /**
   *
   * 推荐项目
   */
  Future<List<RecommProjectData>?> getProject() async {
    DioUtil.getInstance()?.openLog();
    DioResponse baseResp = await DioUtil().request("/project/list/0/json", method: DioMethod.get,
        params: {"cid":"402","page_size":"6"});

    if (baseResp.errorCode != DioResponseCode.SUCCESS) {
      return Future.error(Exception(baseResp.errorMsg));
    }

    RecommProjectArray projectArray = RecommProjectArray.fromJson(baseResp.data);
    return projectArray.data;
  }
  /**
   * 推荐公众号
   */
  Future<List<ArticleData>?> getArticle() async {
    DioUtil.getInstance()?.openLog();
    DioResponse baseResp = await DioUtil().request("/article/list/0/json", method: DioMethod.get,
        params: {"page_size":"6"});

    if (baseResp.errorCode != DioResponseCode.SUCCESS) {
      return Future.error(Exception(baseResp.errorMsg));
    }

    ArticleArray articArray = ArticleArray.fromJson(baseResp.data);
    return articArray.data;
  }

  /**
   * 收藏
   */
  Future<bool?> collect(int id) async{
    DioUtil.getInstance()?.openLog();
    DioResponse baseResp = await DioUtil().request(Utils.getPath(path: "/lg/collect/",page: id),
        method:DioMethod.post);
    if (baseResp.errorCode != DioResponseCode.SUCCESS) {
      return false;
    }
    return true;
  }
  /**
   * 收藏
   */
  Future<bool?> unCollect(int id) async{
    DioUtil.getInstance()?.openLog();
    DioResponse baseResp = await DioUtil().request(Utils.getPath(path: "/lg/uncollect_originId",page: id),
        method:DioMethod.post);
    if (baseResp.errorCode != DioResponseCode.SUCCESS) {
      return false;
    }
    return true;
  }
  /**
   * 登录
   */
  Future<UserData?> login(String userName,String pwd) async{
    DioUtil.getInstance()?.openLog();
    DioResponse baseResp = await DioUtil().request("/user/login",
        method:DioMethod.post,
        params: {"username":userName,"password":pwd});
    if (baseResp.errorCode != DioResponseCode.SUCCESS) {
      return Future.error(Exception(baseResp.errorMsg));
    }
    if (baseResp.headers !=null){
        baseResp.headers!.forEach((String name, List<String> values) {
          if (name == "set-cookie") {
            String cookie = values.toString();
            print("set-cookie: " + cookie);
            SpUtil.putString(Constant.keyAppToken, cookie);
            // DioUtil().setCookie(cookie);
          }
        });
    };
    UserData  userData = UserData.fromJson(baseResp.data);
    return userData;
  }
  Future<bool?> logout() async{
    DioUtil.getInstance()?.openLog();
    DioResponse baseResp = await DioUtil().request("/user/logout/json",
        method:DioMethod.post);
    if (baseResp.errorCode != DioResponseCode.SUCCESS) {
      return   false;
    }

    return true;
  }

  /**
   *
   * tab项目
   */
  Future<List<RecommProjectData>?> getProjectData(int page) async {
    DioUtil.getInstance()?.openLog();
    DioResponse baseResp = await DioUtil().request(Utils.getPath(path: "/article/listproject/",page : page), method: DioMethod.get);

    if (baseResp.errorCode != DioResponseCode.SUCCESS) {
      return Future.error(Exception(baseResp.errorMsg));
    }

    RecommProjectArray projectArray = RecommProjectArray.fromJson(baseResp.data);
    return projectArray.data;
  }

}
