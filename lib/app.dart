import 'dart:developer';
import 'package:ecommerce/repositories/auth/bloc/authentication_bloc.dart';
import 'package:ecommerce/theme.dart';
import 'package:ecommerce/utils/modules/home/bloc/home_bloc.dart';
import 'package:ecommerce/utils/modules/home/views/home_main.dart';
import 'package:ecommerce/utils/modules/home/views/home_view.dart';
import 'package:ecommerce/utils/modules/login/screens/login_page.dart';
import 'package:ecommerce/utils/services/shared_preference/shared_preference.dart';
import 'package:flutter/physics.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/app_constants.dart';
import 'constants/navigation_constants.dart';
import 'repositories/auth/repository/authentication_repository.dart';
import 'utils/helpers/internet/internet_cubit.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'utils/modules/splash/screens/splash_page.dart';

class App extends StatelessWidget {
  const App(
      {Key? key,
      required this.authenticationRepository,
      required this.connectivity})
      : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final Connectivity connectivity;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<InternetCubit>(
            create: (context) => InternetCubit(connectivity: connectivity),
          ),
          BlocProvider(
              create: (_) => AuthenticationBloc(
                  authenticationRepository: authenticationRepository)),
          BlocProvider(
              create: (_) => HomeBloc()),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  SharedPreference sharedPreference = SharedPreference();
  String theme="";

  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;



  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }






  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        navigatorKey: _navigatorKey,
      theme: themeLight,
      locale: const Locale("en"),
      localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) {
        return locale;
      },
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) async {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                      (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                  _navigator.pushAndRemoveUntil<void>(
                    LoginPage.route(),
                        (route) => false,
                  );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      routes: {
        '/': (context) =>  SplashPage(),
        loginPage: (context) => const LoginPage(),
      },
    );
  }
}
