part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._(
      this.user, {
        this.status = AuthenticationStatus.unknown,
      });

  const AuthenticationState.unknown(UserModel user) : this._(user);

  const AuthenticationState.authenticated(UserModel user)
      : this._(user,status: AuthenticationStatus.authenticated);

  const AuthenticationState.unauthenticated(UserModel user)
      : this._(user,status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final UserModel user;

  @override
  List<Object> get props => [status, user];
}
