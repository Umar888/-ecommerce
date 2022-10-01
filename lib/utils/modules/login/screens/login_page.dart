import 'package:ecommerce/repositories/auth/repository/authentication_repository.dart';
import 'package:ecommerce/utils/modules/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationRepository:
            RepositoryProvider.of<AuthenticationRepository>(context),
          );
        },
        child: LoginForm(),
      ),
    );
  }
}