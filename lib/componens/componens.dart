import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/lay_out/shop_lay_out/cubit/home_cubit.dart';
import 'package:shopapp/modules/login_screen/bloc/bloc_login_screen.dart';
import 'package:shopapp/modules/search/cubit/cubitSearch.dart';
import 'package:shopapp/style/colors/color.dart';
String? token  ;
Widget defaultTextFormField ({
  required String lapel ,
  required TextEditingController controler ,
  required Widget icon,
  bool isPassword = false,
  GestureTapCallback? onTapSuffixIcon,
  IconData? suffixIcon,
  FormFieldValidator? validator ,
  ValueChanged<String>? onFieldSubmitted ,
  TextInputType keyboardType = TextInputType.emailAddress ,
  context,
})
=> TextFormField(
      controller: controler ,
      keyboardType: keyboardType,
      obscureText:isPassword ,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration (
        label:Text(
            lapel,
        ),
        prefixIcon: icon,
        border: OutlineInputBorder(),
       focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
        color: defaultColor,
      ),
    ),
       suffixIcon: InkWell(
          onTap: onTapSuffixIcon,
          child: Icon(suffixIcon),
        )
      ) ,
);

Widget defaultMatrialButton({
  required VoidCallback function ,
  required String text ,

})
=>
MaterialButton(
    onPressed: function ,
    height:45,
    color: defaultColor,
    minWidth: double.infinity,
    child: Text(
      text.toUpperCase(),
         style: const TextStyle(
           color: Colors.white
         ),
    ),
) ;

Widget defaultTextButton ({
  context,
   required Widget widget,
   required String text,
   bool isUpperCase = true ,
}
    ) =>
    TextButton(
  onPressed: (){
   Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder:(context)=> widget,
        ),
            (route) => false);
  },
  child:Text(
    isUpperCase?text.toUpperCase():text,
    style: const TextStyle(
      color:defaultColor,
    ),
  ),
);

void showToast({
  required String message ,
  required ToastStates toastState ,
}) =>
    Fluttertoast.showToast(
  msg: message ,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: choseColorToast(toastState),
  textColor: Colors.white,
  fontSize: 16.0,
);

enum ToastStates {ERROR,SUCCESS,WARNING}

Color choseColorToast(ToastStates state){
  Color? color ;

  switch(state){
    case ToastStates.ERROR :
       color = Colors.red ;
        break ;
    case ToastStates.SUCCESS :
      color = defaultColor ;
      break ;
    case ToastStates.WARNING :
      color = Colors.amberAccent ;
      break ;
   }

   return color ;
}
void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match){
    print(match);
  });

}


