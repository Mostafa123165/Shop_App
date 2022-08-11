import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componens/componens.dart';
import 'package:shopapp/lay_out/shop_lay_out/cubit/home_cubit.dart';
import 'package:shopapp/modules/class_model_Login/model_login.dart';
import 'package:shopapp/modules/login_screen/bloc/state_login_screen.dart';
import 'package:shopapp/network/dio_helper.dart';

class BlocLoginScreen extends Cubit <LoginState>{
  BlocLoginScreen() : super(InitialState());
  LoginModel_RegisterModel? loginModel ;
  static BlocLoginScreen get(context) => BlocProvider.of(context) ;
  bool isPasswordVisibility = false ;
  IconData? suffixIcon  ;

  void changeObscureTextPassword (){
    isPasswordVisibility = !isPasswordVisibility ;
    suffixIcon =  isPasswordVisibility ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeObscureTextPasswordState());
  }

  void userLogin({required String email , required String password,}){
    emit(LoadingLoginState());
    DioHelper.posDate(
    url: 'login',
    data:{
      'email':email,
      'password':password,
      }
    ).then((value) {
      print(value.data);
      loginModel = LoginModel_RegisterModel.fromJson(value.data);
      emit(SuccessLoginState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ErrorLoginState(error.toString()));
    });
  }

}