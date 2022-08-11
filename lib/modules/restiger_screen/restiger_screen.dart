import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componens/componens.dart';
import 'package:shopapp/lay_out/shop_lay_out/Shop_Lay_Out.dart';
import 'package:shopapp/modules/login_screen/bloc/bloc_login_screen.dart';
import 'package:shopapp/modules/restiger_screen/bloc/bloc_restiger_screen.dart';
import 'package:shopapp/modules/restiger_screen/bloc/state_restiger_screen.dart';
import 'package:shopapp/network/cash_helper.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controlerRegisterEmailAddress= TextEditingController() ;
    var controlerRegisterPassword= TextEditingController() ;
    var controlerRegisterName= TextEditingController() ;
    var controlerRegisterPhone= TextEditingController() ;
    var formKey = GlobalKey<FormState>() ;
    return BlocProvider(
      create: (_) => BlocRegisterScreen(),
      child: BlocConsumer<BlocRegisterScreen,RegisterState>(
        listener:(context,state) {
          if(state is RegisterSuccessState){
            if(state.registerModel.status!){
              CashHelper.saveDate(
                  key: 'token',
                  value: state.registerModel.data!.token).then((value) {
                    token = state.registerModel.data!.token!;
                   Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder:(context)=> ShopLayOut(),
                    ),
                        (route) => false);
              });
            }
            else {
              showToast(
                message: state.registerModel.message.toString(),
                toastState: ToastStates.ERROR ,
              ) ;
            }
          }
        },
        builder:(context,state) {
          return Scaffold(
            appBar: AppBar(elevation: 0.0,),
            body:Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        const Text(
                          'Register',
                           style: TextStyle(
                             fontSize:20.0,
                           ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Register Now to browser our hot offers ',
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                            lapel:'User Name',
                            keyboardType: TextInputType.name,
                            icon: const Icon(Icons.person),
                            controler: controlerRegisterName,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return 'User name must not empty ' ;
                              }
                              return null ;
                            }
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                          lapel:'Email Address',
                          icon: Icon(Icons.email),
                          controler: controlerRegisterEmailAddress,
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (value){} ,
                          validator:  (value){
                            if(value == null || value.isEmpty){
                              return 'Email Address must not empty ' ;
                            }
                            return null ;
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                          lapel:'Password',
                          icon: Icon(Icons.lock_outline),
                          controler: controlerRegisterPassword,
                          keyboardType: TextInputType.number,
                          onFieldSubmitted: (value){

                          } ,
                          validator:  (value){
                            if(value == null || value.isEmpty){
                              return 'Password is too short ' ;
                            }
                            return null ;
                          },
                          suffixIcon:BlocRegisterScreen.get(context).suffixIcon ,
                          onTapSuffixIcon:(){
                            BlocRegisterScreen.get(context).changeObscureTextPassword();
                          },
                          isPassword: BlocRegisterScreen.get(context).isPasswordVisibility,
                          context:context,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                          lapel:'Phone',
                          icon: const Icon(Icons.phone),
                          controler: controlerRegisterPhone,
                          keyboardType: TextInputType.phone,
                          onFieldSubmitted: (value){} ,
                          validator:  (value){
                            if(value == null || value.isEmpty){
                              return 'Phone must not empty' ;
                            }
                            return null ;
                          },
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is !RegisterLoadingState,
                          builder: (context) => defaultMatrialButton(
                              function: (){
                                if(formKey.currentState!.validate()) {
                                  BlocRegisterScreen.get(context).userRegister(
                                    email:controlerRegisterEmailAddress.text,
                                    password: controlerRegisterPassword.text,
                                    name:  controlerRegisterName.text,
                                    phone: controlerRegisterPhone.text,
                                  );
                                }
                              },
                              text:'LOGIN'
                          ),
                          fallback:(context)=> Center(child: CircularProgressIndicator()),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ) ;
        } ,
      ),
    );
  }
}
