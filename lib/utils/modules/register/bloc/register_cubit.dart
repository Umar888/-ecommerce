import 'package:bloc/bloc.dart';
import 'package:ecommerce/repositories/auth/model/user_model.dart';
import 'package:ecommerce/repositories/auth/repository/authentication_repository.dart';
import 'package:ecommerce/utils/modules/register/models/models.dart';
import 'package:ecommerce/utils/services/shared_preference/shared_preference.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._authenticationRepository) : super(const RegisterState());

  final AuthenticationRepository _authenticationRepository;
  final SharedPreference _sharedPref = SharedPreference();

  void userNameChanged(String value) {
    final userName = UserName.dirty(value);
    emit(state.copyWith(
      userName: userName,
      status: Formz.validate([
        userName,
        state.email,
        state.dob,
        state.password,
        state.confirmedPassword,
        state.isTermCondition
      ]),
    ));
  }

  void dobChanges(String value) {
    final dob = DateOfBirth.dirty(value);
    emit(state.copyWith(
      dob: dob,
      status: Formz.validate([
        state.userName,
        state.email,
        dob,
        state.password,
        state.confirmedPassword,
        state.isTermCondition
      ]),
    ));
  }

  void mapPasswordVisibilityChangedToState() {
    emit(state.copyWith(
      isConfirmPasswordVisible: state.isConfirmPasswordVisible,
      isPasswordVisible: state.isPasswordVisible?false:true,
      status: Formz.validate([
        state.userName,
        state.email,
        state.dob,
        state.password,
        state.confirmedPassword,
        state.isTermCondition
      ]),
    ));
  }

  void mapConfirmPasswordVisibilityChangedToState() {
    emit(state.copyWith(
      isConfirmPasswordVisible: state.isConfirmPasswordVisible?false:true,
      isPasswordVisible: state.isPasswordVisible,
      status: Formz.validate([
        state.userName,
        state.email,
        state.dob,
        state.password,
        state.confirmedPassword,
        state.isTermCondition
      ]),
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        state.userName,
        email,
        state.dob,
        state.password,
        state.confirmedPassword,
        state.isTermCondition
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(state.copyWith(
      password: password,
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.userName,
        state.email,
        state.dob,
        password,
        state.confirmedPassword,
        state.isTermCondition
      ]),
    ));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.userName,
        state.email,
        state.dob,
        state.password,
        confirmedPassword,
        state.isTermCondition
      ]),
    ));
  }

  void isTermAndConditionChange(bool value){
    final isTermCondition = IsTermCondition.dirty(value);
    emit(state.copyWith(
      isTermCondition: isTermCondition,
      status: Formz.validate([
        state.userName,
        state.dob,
        state.email,
        state.password,
        state.confirmedPassword,
        isTermCondition
      ]),
    ));
  }
  void emptyMessage(){
    emit(state.copyWith(
      message: "",
      status: Formz.validate([
        state.userName,
        state.dob,
        state.email,
        state.password,
        state.confirmedPassword,
        state.isTermCondition
      ]),
    ));
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {


      UserModel userModel = await _authenticationRepository.signUp(
          userName: state.userName.value,
          email: state.email.value,
          password: state.password.value,
          dob: state.dob.value,
      );

      if(userModel.status!){
        emit(state.copyWith(
            status: FormzStatus.submissionSuccess,
            message: userModel.message
        ));
      }else{
        emit(state.copyWith(
            status: FormzStatus.submissionFailure,
            message: userModel.message));
      }
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
