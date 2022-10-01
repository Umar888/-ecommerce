import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:ecommerce/repositories/auth/model/user_model.dart';
import 'package:ecommerce/repositories/auth/repository/authentication_repository.dart';
import 'package:ecommerce/utils/modules/login/models/email.dart';
import 'package:ecommerce/utils/services/shared_preference/shared_preference.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';

import '../../register/models/password.dart';

part 'login_event.dart';
part 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })   : _authenticationRepository = authenticationRepository,
        super(const LoginState());

  final AuthenticationRepository _authenticationRepository;
  SharedPreference sharedPref = SharedPreference();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email','https://www.googleapis.com/auth/userinfo.profile']);

  @override
  Stream<LoginState> mapEventToState(
      LoginEvent event,
      ) async* {
    if (event is LoginEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is ChangeVisibility) {
      yield state.copyWith(isPasswordVisible: event.isVisible);
    }else if (event is EmptyMessage) {
      yield state.copyWith(message: "");
    } else if (event is LoginWithGoogle) {
      yield* _mapGoogleLoginSubmittedToState(event, state);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    }
  }

  LoginState _mapEmailChangedToState(
      LoginEmailChanged event,
      LoginState state,
      ) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([state.password, email]),
    );
  }

  LoginState _mapPasswordChangedToState(
      LoginPasswordChanged event,
      LoginState state,
      ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.email]),
    );
  }

  Stream<LoginState> _mapLoginSubmittedToState(
      LoginSubmitted event,
      LoginState state,
      ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        UserModel userModel = await _authenticationRepository.logIn(
          email: state.email.value,
          password: state.password.value,
        );
        print("userModel.message ${userModel.message}");
        print("userModel.message ${userModel.status}");
        if(userModel.status!){
          emit(state.copyWith(
              status: FormzStatus.submissionSuccess,
              message: userModel.message
          ));
        }
        else{
          emit(state.copyWith(
              status: FormzStatus.submissionFailure,
              message: userModel.message));
        }
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure, message: 'Something went wrong!');
      }
    }
  }


  Stream<LoginState> _mapGoogleLoginSubmittedToState(
      LoginWithGoogle event,
      LoginState state,
      ) async* {

      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {

        UserModel userModel = await _authenticationRepository.socialMedia();
           print(userModel.message);
            if(userModel.status!){
              emit(state.copyWith(
                  status: FormzStatus.submissionSuccess,
                  message: userModel.message
              ));
            }
            else{
              emit(state.copyWith(
                  status: FormzStatus.invalid,
                  message: userModel.message
              ));
            }

      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.invalid, message: 'Something went wrong!');
      }

  }

}