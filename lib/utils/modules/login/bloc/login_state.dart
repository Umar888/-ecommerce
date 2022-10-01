part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.message = '',
    this.isPasswordVisible = false,
    this.status = FormzStatus.pure,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  final FormzStatus status;
  final Email email;
  final bool isPasswordVisible;
  final Password password;
  final String message;

  LoginState copyWith({
    FormzStatus? status,
    Email? email,
    Password? password,
    String? message,
    bool? isPasswordVisible
  }) {
    return LoginState(
        status: status ?? this.status,
        email: email ?? this.email,
        password: password ?? this.password,
        message: message ?? this.message,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible

    );
  }

  @override
  List<Object> get props => [status, email, password, message,isPasswordVisible];
}