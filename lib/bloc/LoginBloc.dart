import '../model/UserData.dart';
import '../repository/wan_repository.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc{

  WanRepository wanRepository = WanRepository();

  /**
   * login
   */
  BehaviorSubject<UserData> loginSubject = BehaviorSubject<UserData>();
  Sink<UserData?> get loginSink => loginSubject.sink;
  Stream<UserData?> get loginStream => loginSubject.stream;
  /**
   * logout
   */
  BehaviorSubject<bool> logoutSubject = BehaviorSubject<bool>();
  Sink<bool?> get logoutSink => logoutSubject.sink;
  Stream<bool?> get logoutStream => logoutSubject.stream;
  Future<bool?> logout(){
    return wanRepository.logout().then((value){
      logoutSink.add(value);
    });
  }

  Future<List<UserData>?> login(String userName,String pwd){
    return wanRepository.login(userName,pwd).then((value){
      loginSink.add(value);
    });
  }
}