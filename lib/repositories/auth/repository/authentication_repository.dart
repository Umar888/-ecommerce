import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants/api_path_constants.dart';
import 'package:ecommerce/constants/app_constants.dart';
import 'package:ecommerce/repositories/auth/bloc/authentication_helper.dart';
import 'package:ecommerce/repositories/auth/model/user_model.dart';
import 'package:ecommerce/utils/services/networking/api_provider.dart';
import 'package:ecommerce/utils/services/shared_preference/shared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final ApiProvider _apiProvider = ApiProvider();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SharedPreference _sharedPref = SharedPreference();
  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept-Charset': 'utf-8'
  };

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.authenticated;
    yield* _controller.stream;
  }

  Future<UserModel> socialMedia() async {
  UserModel user_model =  await AuthenticationHelper().signInWithGoogle();

    if(user_model != null){
      if(user_model.status!){
        await _sharedPref.saveJson(sharedPrefUser, user_model.toJson());
        _controller.add(AuthenticationStatus.authenticated);
      }
      return user_model;
    }
    else{
      return UserModel(status: false,message: "Google login failed");
    }
  }



  Future<dynamic> logIn({required String email, required String password}) async {

    String result = await AuthenticationHelper()
        .signIn(email: email, password: password);

    if(result.isNotEmpty){
      return UserModel(status: false,message: result);
    }
    else{
      User user = AuthenticationHelper().user;
      if(user != null){
        DocumentSnapshot<Map<String, dynamic>> value= await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

          if(value.exists){
            await _sharedPref.saveJson(sharedPrefUser, UserModel(status: true,message: "Login successful",name: value["name"],email: email, uid: user.uid).toJson());
            _controller.add(AuthenticationStatus.authenticated);
            return UserModel(status: true,message: "Login successful",name: value["name"],email: email, uid: user.uid);
          }
          else{
            return UserModel(status: false,message: "User not found");
          }

      }
      else{
        return UserModel(status: false,message: "User not found");
      }
  }
  }

  Future<UserModel> signUp({required String userName,required String email, required String password, required String dob}) async {
    String result = await AuthenticationHelper()
        .signUp(email: email, password: password);
    if(result.isNotEmpty){
      return UserModel(status: false,message: result);
    }
    else{

      User user = await AuthenticationHelper().user;
      if(user != null){
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          "name":userName,
          "email":email,
          "dob":dob
        });
        await _sharedPref.saveJson(sharedPrefUser, UserModel(status: true,message: "Registration successful",name: userName,email: email, uid: user.uid).toJson());
        _controller.add(AuthenticationStatus.authenticated);
        return UserModel(status: true,message: "Registration successful",name: userName,email: email, uid: user.uid);
      }
      else{
        return UserModel(status: false,message: "Registration failed");
      }
    }


  }

  void logOut() async {
    await _sharedPref.remove(sharedPrefUser);
    AuthenticationHelper().signOut();
    _controller.add(AuthenticationStatus.unauthenticated);
  }
  void dispose() => _controller.close();
}