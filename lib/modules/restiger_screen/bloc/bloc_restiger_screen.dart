import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componens/componens.dart';
import 'package:shopapp/modules/class_model_Login/model_login.dart';
import 'package:shopapp/modules/restiger_screen/bloc/state_restiger_screen.dart';
import 'package:shopapp/network/cash_helper.dart';
import 'package:shopapp/network/dio_helper.dart';

class BlocRegisterScreen extends Cubit <RegisterState>{
  BlocRegisterScreen() : super(InitialRegisterState());
  static BlocRegisterScreen get(context) => BlocProvider.of(context) ;
  bool isPasswordVisibility = false ;
  IconData? suffixIcon  ;

  void changeObscureTextPassword (){
    isPasswordVisibility = !isPasswordVisibility ;
    suffixIcon =  isPasswordVisibility ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeRegisterObscureTextPasswordState());
  }
  LoginModel_RegisterModel? registerModel ;

  void userRegister({required String email , required String password ,required String name,required String phone }){
    emit(RegisterLoadingState());
    DioHelper.posDate(
        url: 'register',
        data:{
          'email':email,
          'password':password,
          'phone':phone,
          'name':name,
        }
    ).then((value) {
      print(value.data);
      registerModel = LoginModel_RegisterModel.fromJson(value.data);
      emit(RegisterSuccessState(registerModel!));
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }


}