import 'package:shopapp/modules/class_model_Login/model_login.dart';

abstract class LoginState {}

 class InitialState extends LoginState {}

 class ChangeObscureTextPasswordState extends LoginState {}

 class  LoadingLoginState extends LoginState {}

 class  SuccessLoginState extends LoginState {
    final  LoginModel_RegisterModel loginModel ;
    SuccessLoginState(this.loginModel);
 }

 class ErrorLoginState extends LoginState{
     final String error ;
    ErrorLoginState(this.error);
 }
