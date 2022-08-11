import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componens/componens.dart';
import 'package:shopapp/lay_out/shop_lay_out/cubit/home_cubit.dart';
import 'package:shopapp/lay_out/shop_lay_out/cubit/home_state.dart';
import 'package:shopapp/modules/login_screen/login_screen.dart';
import 'package:shopapp/network/cash_helper.dart';

class SettingsScreen extends StatelessWidget {

/*  var nameControler = TextEditingController();
  var emailControler = TextEditingController();
  var phoneControler = TextEditingController();*/

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => HomeCubit()..getDateProfile(),
      child: BlocConsumer<HomeCubit,HomeMainState>(

        listener:(context , state){} ,
        builder:(context , state){



          var model = HomeCubit.get(context).dateProfile ;
          /*nameControler.text  =  model!.data!.name! ;
          emailControler.text = model.data!.email!;
          phoneControler.text = model.data!.phone! ;*/
          return ConditionalBuilder(
            //condition:state is! GetDataUserLoadingState,
            condition:  HomeCubit.get(context).dateProfile != null ,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is UpdateLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 15.0,),
                  defaultTextFormField(
                    lapel: 'name',
                    controler:HomeCubit.get(context).nameControler,
                    icon:Icon(Icons.person),
                    isLightMode:HomeCubit.get(context).isLightMode!,
                      color: HomeCubit.get(context).isLightMode!  ? Colors.black: Colors.red
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  defaultTextFormField(
                    lapel: 'Email Address',
                    controler:HomeCubit.get(context).emailControler,
                    icon:Icon(Icons.email),
                    isLightMode:HomeCubit.get(context).isLightMode!,
                    color: HomeCubit.get(context).isLightMode!  ? Colors.black: Colors.red
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  defaultTextFormField(
                    lapel: 'Phone',
                    controler:HomeCubit.get(context).phoneControler,
                    icon:Icon(Icons.phone),
                     isLightMode:HomeCubit.get(context).isLightMode!,
                      color: HomeCubit.get(context).isLightMode!  ? Colors.black: Colors.red
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  defaultMatrialButton(
                      function: (){
                        CashHelper.removeDate(key:'token',).then((value) {
                          CashHelper.clearAllData();
                          if(value){
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ), (route) => false);
                          }
                        });
                      },
                      text: 'LOGOUT'
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  defaultMatrialButton(
                      function: (){
                        HomeCubit.get(context).updateDate(
                            name:HomeCubit.get(context).nameControler.text,
                            email:HomeCubit.get(context).emailControler.text,
                            phone:HomeCubit.get(context).phoneControler.text,
                        );
                      },
                      text: 'UPDATE'
                  ),
                ],
              ),
            ),
            fallback:(context) =>const Center(child:  CircularProgressIndicator()),
          );
        } ,
      ),
    );
  }
}
