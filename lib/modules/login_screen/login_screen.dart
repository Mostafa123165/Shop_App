import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componens/componens.dart';
import 'package:shopapp/lay_out/shop_lay_out/Shop_Lay_Out.dart';
import 'package:shopapp/lay_out/shop_lay_out/cubit/home_cubit.dart';
import 'package:shopapp/modules/login_screen/bloc/bloc_login_screen.dart';
import 'package:shopapp/modules/login_screen/bloc/state_login_screen.dart';
import 'package:shopapp/modules/restiger_screen/restiger_screen.dart';
import 'package:shopapp/network/cash_helper.dart';
import 'package:shopapp/style/colors/color.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final  controlerEmailAddress= TextEditingController() ;
    final  controlerPassword= TextEditingController() ;
    var formKey = GlobalKey<FormState>() ;
    return BlocProvider(
      create: (_) => BlocLoginScreen(),

      child: BlocConsumer<BlocLoginScreen,LoginState>(
        listener:(context,state) {
          if(state is SuccessLoginState){
            if(state.loginModel.status!){
               CashHelper.saveDate(
                   key: 'token',
                   value: state.loginModel.data!.token).then((value) {
                     Navigator.pushAndRemoveUntil(
                     context,
                     MaterialPageRoute(
                       builder:(context)=> ShopLayOut(),
                     ),
                         (route) => false);
               });
            }
            else {
              print('moooooooooooooooostafaaaaaaaaaaaaaaaaaa');
              showToast(
                  message: state.loginModel.message.toString(),
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
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text(
                          'Login Now to browser our hot offers ',
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultTextFormField(
                          lapel:'Email Address',
                          icon: Icon(Icons.email),
                          controler: controlerEmailAddress,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Please enter your mail address' ;
                            }
                            return null ;
                          }
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultTextFormField(
                          lapel:'Password',
                          icon: Icon(Icons.lock_outline),
                          controler: controlerPassword,
                          keyboardType: TextInputType.numberWithOptions(),
                          onFieldSubmitted: (value){
                            if(formKey.currentState!.validate()) {
                              BlocLoginScreen.get(context).userLogin(
                                email:controlerEmailAddress.text
                                ,password: controlerPassword.text,);
                            }
                          },
                          validator:  (value){
                            if(value == null || value.isEmpty){
                              return 'Password is short' ;
                            }
                            return null ;
                          },
                          suffixIcon:BlocLoginScreen.get(context).suffixIcon ,
                          onTapSuffixIcon:(){
                            BlocLoginScreen.get(context).changeObscureTextPassword();
                          },
                          isPassword: BlocLoginScreen.get(context).isPasswordVisibility,
                          context:context,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                            condition: state is !LoadingLoginState,
                            builder: (context) => defaultMatrialButton(
                                function: (){
                                  if(formKey.currentState!.validate()) {
                                    HomeCubit.get(context).getDateFavourite() ;
                                    BlocLoginScreen.get(context).userLogin(
                                     email:controlerEmailAddress.text
                                    ,password: controlerPassword.text,
                                    );
                                  }
                                },
                                text:'LOGIN'
                            ),
                          fallback:(context)=> const Center(child: CircularProgressIndicator()),
                        ),

                        const SizedBox(
                          height: 22.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            const Text(
                              'Don\'t have an account?' ,
                            ),
                            TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(
                                  builder:(context) => RegisterScreen(),
                              )
                              );
                            }, child: const Text(
                                'register',
                              style: TextStyle(
                                color: defaultColor ,
                              ),
                              )
                            ),
                          ],
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
