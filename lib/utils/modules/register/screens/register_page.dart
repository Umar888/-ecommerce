import 'package:ecommerce/repositories/auth/repository/authentication_repository.dart';
import 'package:ecommerce/utils/modules/register/bloc/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 6,top: 45,right: 6,bottom: 8),
        child: BlocProvider<RegisterCubit>(
          create: (_) => RegisterCubit(context.read<AuthenticationRepository>()),
          child: const RegisterForm(),
        ),
      ),
    );
  }
}