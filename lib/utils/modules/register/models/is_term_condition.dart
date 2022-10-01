import 'package:formz/formz.dart';

enum IsTermConditionValidationError { invalid }

class IsTermCondition extends FormzInput<bool, IsTermConditionValidationError> {
  const IsTermCondition.pure() : super.pure(false);
  const IsTermCondition.dirty([bool value = false]) : super.dirty(value);

  @override
  IsTermConditionValidationError? validator(bool value) {
    if(value){
      return null;
    }else{
      return IsTermConditionValidationError.invalid;
    }
  }
}