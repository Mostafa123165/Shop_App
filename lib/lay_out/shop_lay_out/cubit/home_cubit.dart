import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componens/componens.dart';
import 'package:shopapp/lay_out/shop_lay_out/cubit/home_state.dart';
import 'package:shopapp/lay_out/shop_lay_out/model_shop/mode_shop.dart';
import 'package:shopapp/modules/category/category_screen.dart';
import 'package:shopapp/modules/category/model/model_categories.dart';
import 'package:shopapp/modules/class_model_Login/model_login.dart';
import 'package:shopapp/modules/favourite/favourite_screen.dart';
import 'package:shopapp/modules/favourite/model/get_favourite_data.dart';
import 'package:shopapp/modules/favourite/model/model_favourite.dart';
import 'package:shopapp/modules/products/products_screen.dart';
import 'package:shopapp/modules/settings/setting_screen.dart';
import 'package:shopapp/network/cash_helper.dart';
import 'package:shopapp/network/dio_helper.dart';

class HomeCubit extends Cubit<HomeMainState> {
  HomeCubit() : super (InitialState()) ;
  static HomeCubit get(context) => BlocProvider.of(context) ;
  var token =  CashHelper.getDate(key: 'token') ; // جبيته هنا لي ؟

  int currentIndex = 0 ;


  List<Widget>bottomScreen = [
    const ProductsScreen(),
    const CategoryScreen(),
    const FavouriteScreen(),
     SettingsScreen(),
  ] ;
  void changBottomNav(int index){
    currentIndex = index ;
    emit(ChangBottomState()) ;
  }
  ModelShop? shopModel;
  Map<int ,bool> favourite = {};

  void getDataHome(){
    emit(ShopLoadingHomeDateState()) ;

    DioHelper.getDate(
        methodUrl:'home',
        token: token,
    ).then((value) {

      shopModel = ModelShop.fromJson(value.data);
        shopModel!.data!.products.forEach((element) {
          favourite.addAll({
            element.id! : element.inFavorites!,
          });
        });

      emit(ShopSuccessHomeDateState());

    }).catchError((error){
      emit(ShopErrorHomeDateState());
      print(error.toString()) ;
    });

  }

  ModelCategories? categoriesModel;
  void getDataCategories(){
    emit(ShopLoadingCategoriesDateState()) ;

    DioHelper.getDate(methodUrl:'categories').then((value) {

      categoriesModel = ModelCategories.fromJson(value.data);
     // print(categoriesModel?.data?.data[0].image);
      emit(ShopSuccessCategoriesDateState());

    }).catchError((error){
      emit(ShopErrorCategoriesDateState());
      print(error.toString()) ;
    });
  }
  ChangeModelFavourite? modelFavourite ;
  void changeFavorites (int? idProducts , int index){

    print('aaaaaaaaa${favourite.length}');
    print('aaaaaaaaa${favourite[idProducts!]}');
    favourite[idProducts] =!(favourite[idProducts]!) ;
   // shopModel!.data!.products[index].inFavorites = shopModel!.data!.products[index].inFavorites == false;
    emit(ChangeFavoritesState());
    DioHelper.posDate(
        url: 'favorites',
        data: {
          'product_id': idProducts,
        },
      token:token ,
    ).then((value) {
      modelFavourite = ChangeModelFavourite.fromJson(value.data) ;

      if(modelFavourite!.status == false){
        favourite[idProducts] =!(favourite[idProducts]!) ;
      }
      else{
        getDateFavourite();
      }
      emit(ChangeSuccessFavoritesState(modelFavourite!));

    }).
    catchError((error){
      favourite[idProducts] =!(favourite[idProducts]!) ;
      emit(ChangeErrorFavoritesState());
      print(error.toString()) ;
    });
  }

  ModleGetDateFavourite? modeGetDateFavourite ;
  void getDateFavourite(){
    emit(GetDataFavouriteLoadingState());
    DioHelper.getDate(
        methodUrl: 'favorites',
        token: token,
    ).then((value) {
      modeGetDateFavourite =  ModleGetDateFavourite.fromJson(value.data!) ;
      modeGetDateFavourite!.data!.dateProducts.forEach((element) {
        favourite.addAll({
          element.products!.id : true ,
        });
      });
      //print(value.data);
      emit(GetDataFavouriteSuccessState()) ;
    }).catchError((error){

      print(error.toString());
      emit(GetDataFavouriteErrorState()) ;
    });
  }
  LoginModel_RegisterModel? dateProfile ;
  var nameControler = TextEditingController();
  var emailControler = TextEditingController();
  var phoneControler = TextEditingController();

  void getDateProfile(){
    emit(GetDataUserLoadingState());
    DioHelper.getDate(
        methodUrl:'profile',
        token: token,
    ).then((value) {
      dateProfile = LoginModel_RegisterModel.fromJson(value.data);
      nameControler.text  =  dateProfile!.data!.name! ;
      emailControler.text = dateProfile!.data!.email!;
      phoneControler.text = dateProfile!.data!.phone! ;
      emit(GetDataUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(GetDataUserErrorState());
    });
  }
  void updateDate({required String name , required String email ,required String phone}){
    emit(UpdateLoadingState());
    DioHelper.putDate(
        url: 'update-profile',
        data:{
          'email':email,
          'phone':phone,
          'name':name,
        },
        token: token,
    ).then((value) {
      print(value.data);
      dateProfile = LoginModel_RegisterModel.fromJson(value.data);
      print(dateProfile!.data!.name);
      emit(UpdateSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(UpdateErrorState());
    });
  }
   bool? isLightMode = false ;
  void changeAppMode({bool? fromShared}){
    emit(LoadChangeColorModeErrorState());
    if(fromShared == null){
      isLightMode = !isLightMode! ;
    }
    else {
      isLightMode = fromShared ;
    }
    CashHelper.saveDate(
        key: 'isLightMode',
        value:isLightMode ,
    ).then((value) {
      emit(ChangeColorModeSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(ChangeColorModeErrorState());
    });
  }


}
