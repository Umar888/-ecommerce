import 'package:formz/formz.dart';

enum ConfirmPasswordValidationError { invalid }

class ConfirmedPassword extends FormzInput<String, ConfirmPasswordValidationError> {
  const ConfirmedPassword.pure({this.password = ''}) : super.pure('');
  const ConfirmedPassword.dirty({required this.password, String value = ''}) : super.dirty(value);

  final String password;

  @override
  ConfirmPasswordValidationError? validator(String? value) {
    return password == value ? null : ConfirmPasswordValidationError.invalid;
  }
}