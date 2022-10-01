import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ecommerce/constants/app_constants.dart';
import 'package:ecommerce/repositories/auth/model/user_model.dart';
import 'package:ecommerce/repositories/auth/repository/authentication_repository.dart';
import 'package:ecommerce/utils/modules/home/models/categories.dart';
import 'package:ecommerce/utils/modules/home/models/second_list.dart';
import 'package:ecommerce/utils/modules/home/models/top_list.dart';
import 'package:ecommerce/utils/modules/login/models/email.dart';
import 'package:ecommerce/utils/services/shared_preference/shared_preference.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

import '../../register/models/password.dart';

part 'home_event.dart';
part 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc():  super(const HomeState());

  SharedPreference sharedPref = SharedPreference();

  @override
  Stream<HomeState> mapEventToState(
      HomeEvent event,
      ) async* {
    if (event is LoadData) {
      yield state.copyWith(homeStateStatus: HomeStateStatus.loadingHome);
      yield await _mapLoadDataToState(event, state);
    } else if (event is TopFavChange) {
      List<TopList> topList = [];
      topList.add(TopList(image: "assets/images/home_assets/top_bar_1.png",price: "AED 150.00",description: "Wooden bedside table featuring a raised design",isFav: event.index == 0?state.topList[0].isFav = !state.topList[0].isFav!: state.topList[0].isFav ,isNew: true));
      topList.add(TopList(image: "assets/images/home_assets/top_bar_5.png",price: "AED 149.99",description: "Chair made of ash sourced wood from responsible source",isFav: event.index == 1?state.topList[1].isFav = !state.topList[1].isFav!: state.topList[1].isFav,isNew: false));
      topList.add(TopList(image: "assets/images/home_assets/top_bar_2.png",price: "AED 200.00",description: "Ash wood table for placing decoration items and book shelf",isFav: event.index == 2?state.topList[2].isFav = !state.topList[2].isFav!: state.topList[2].isFav,isNew: true));
      topList.add(TopList(image: "assets/images/home_assets/top_bar_3.png",price: "AED 199.99",description: "Table for eating of a single person made of pure ash wood",isFav:event.index == 3?state.topList[3].isFav = !state.topList[3].isFav!: state.topList[3].isFav,isNew: false));


      yield state.copyWith(
          topList: topList
      );

    } else if (event is EmptyMessage) {
      yield state.copyWith(message: "");
    } else if (event is CategoriesFavChange) {
      yield await _mapCategoriesFavChangeToState(event, state);
    } else if (event is CategoriesShare) {
      yield await _mapCategoriesShareToState(event, state);
    }
  }

  Future<HomeState> _mapLoadDataToState(LoadData event, HomeState state,) async {

    final List<TopList> topList = [];
    final List<SecondList> secondList = [];
    final List<Categories> categories = [];

    topList.add(TopList(image: "assets/images/home_assets/top_bar_1.png",price: "AED 150.00",description: "Wooden bedside table featuring a raised design",isFav: false,isNew: true));
    topList.add(TopList(image: "assets/images/home_assets/top_bar_5.png",price: "AED 149.99",description: "Chair made of ash sourced wood from responsible source",isFav: false,isNew: false));
    topList.add(TopList(image: "assets/images/home_assets/top_bar_2.png",price: "AED 200.00",description: "Ash wood table for placing decoration items and book shelf",isFav: false,isNew: true));
    topList.add(TopList(image: "assets/images/home_assets/top_bar_3.png",price: "AED 199.99",description: "Table for eating of a single person made of pure ash wood",isFav: false,isNew: false));
  //  topList.add(TopList(image: "assets/images/home_assets/top_bar_4.png",price: "AED 250.00",description: "Rack of ash wood, can be used as a side table and corner piece",isFav: false,isNew: true));

    secondList.add(SecondList(image: "assets/images/home_assets/second_bar_1.png",time: "45 mins",title: "BarBQ Pizza",description: "Perfectly baked pizza in oven with extra layer of cheese and topping of BarBq Chicken",rating: "3.6",totalRatings: "76",));
    secondList.add(SecondList(image: "assets/images/home_assets/second_bar_2.png",time: "30 mins",title: "Chicken Burger",description: "Juicy Burger with perfectly grilled chicken and mayos",rating: "4.0",totalRatings: "80"));
    secondList.add(SecondList(image: "assets/images/home_assets/second_bar_3.png",time: "40 mins",title: "Tortilla Wrap",description: "Tortilla wrapped with chicken and salad with crispy sauces",rating: "4.2",totalRatings: "29"));

    categories.add(Categories(title:"Oasis Event",image: "assets/images/home_assets/categories_1.png",time: "Mon, Apr 18 · 21:00 Pm",isFave: false,location: "Silicon Oasis, Dubai"));
    categories.add(Categories(title:"Waterfall Event",image: "assets/images/home_assets/categories_2.jpeg",time: "Sun, Mar 21 · 21:00 Pm",isFave: false,location: "Lu Waterfall, Dubai"));

    SharedPreference sharedPreference = SharedPreference();
    var userMap = await sharedPreference.readJson(sharedPrefUser);
    UserModel userModel = UserModel.fromJson(userMap);
    return state.copyWith(
      homeStateStatus: HomeStateStatus.successHome,
      topList: topList,
      secondList: secondList,
      categories: categories,
      userName: userModel.name,
      userEmail: userModel.email
    );
  }

  HomeState _mapTopFavChangeToState(
      TopFavChange event,
      HomeState state,
      ) {
    List<TopList> topList = state.topList;
    topList[event.index].isFav = !topList[event.index].isFav!;
    return state.copyWith(
      topList: topList
    );
  }



  Future<HomeState> _mapCategoriesFavChangeToState(
      CategoriesFavChange event,
      HomeState state,
      ) async {

    List<Categories> cats = [];
    cats.add(Categories(title:"Oasis Event",image: "assets/images/home_assets/categories_1.png",time: "Mon, Apr 18 · 21:00 Pm",isFave: event.index == 0?state.categories[0].isFave = !state.categories[0].isFave!: state.categories[0].isFave,location: "Silicon Oasis, Dubai"));
    cats.add(Categories(title:"Waterfall Event",image: "assets/images/home_assets/categories_2.jpeg",time: "Sun, Mar 21 · 21:00 Pm",isFave: event.index == 1?state.categories[1].isFave = !state.categories[1].isFave!: state.categories[1].isFave,location: "Lu Waterfall, Dubai"));

    return state.copyWith(
        categories: cats
    );
  }

  Future<HomeState> _mapCategoriesShareToState(
      CategoriesShare event,
      HomeState state,
      ) async {

    List<Categories> cats = state.categories;
    await Share.share('Check out this awesome offer with E Commerce Application at ${cats[event.index].location} ${cats[event.index].time}', subject: 'Click here open E Commerce Application');

    return state.copyWith(message: "");
  }

}