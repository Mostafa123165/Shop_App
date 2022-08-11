import 'package:shopapp/modules/class_model_Login/model_login.dart';

abstract class RegisterState {}

class InitialRegisterState extends RegisterState {}

class ChangeRegisterObscureTextPasswordState extends RegisterState {}

class  RegisterLoadingState extends RegisterState {}

class  RegisterSuccessState extends RegisterState {
  final  LoginModel_RegisterModel registerModel ;
  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends RegisterState{
  final String error ;
  RegisterErrorState(this.error);
}

