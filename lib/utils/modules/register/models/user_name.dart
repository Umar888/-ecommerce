import 'package:formz/formz.dart';

enum UserNameValidationError { invalid }

class UserName extends FormzInput<String, UserNameValidationError> {
  const UserName.pure() : super.pure('');
  const UserName.dirty([String value = '']) : super.dirty(value);

  @override
  UserNameValidationError? validator(String value) {
    if(value.isNotEmpty && value.length>2){
      return null;
    }else{
      return UserNameValidationError.invalid;
    }
  }
}