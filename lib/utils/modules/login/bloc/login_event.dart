part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class LoginWithGoogle extends LoginEvent {
  const LoginWithGoogle();
  @override
  List<Object> get props => [];
}
class ChangeVisibility extends LoginEvent {
  bool isVisible;
  ChangeVisibility({required this.isVisible});
  @override
  List<Object> get props => [isVisible];
}


class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

class EmptyMessage extends LoginEvent {
  const EmptyMessage();
}