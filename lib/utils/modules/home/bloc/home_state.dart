part of 'home_bloc.dart';

enum HomeStateStatus {loadingHome, successHome, failureHome}

class HomeState extends Equatable {
  const HomeState({
    this.message = '',
    this.userEmail = '',
    this.userName = '',
    this.homeStateStatus = HomeStateStatus.loadingHome,
    this.topList = const [],
    this.secondList = const [],
    this.categories = const []
  });


  final HomeStateStatus homeStateStatus;
  final String message;
  final String userEmail;
  final String userName;
  final List<TopList> topList;
  final List<SecondList> secondList;
  final List<Categories> categories;

  HomeState copyWith({
    HomeStateStatus? homeStateStatus,
    String? message,
    String? userEmail,
    List<TopList>? topList,
    String? userName,
    List<SecondList>? secondList,
    List<Categories>? categories
  }) {
    return HomeState(
        homeStateStatus: homeStateStatus ?? this.homeStateStatus,
        topList: topList ?? this.topList,
        secondList: secondList ?? this.secondList,
        userName: userName ?? this.userName,
        userEmail: userEmail ?? this.userEmail,
        message: message ?? this.message,
        categories: categories ?? this.categories

    );
  }

  @override
  List<Object> get props => [homeStateStatus,userEmail, topList, secondList, message,userName, categories];
}