import 'package:shopapp/modules/class_model_Login/model_login.dart';
import 'package:shopapp/modules/favourite/model/model_favourite.dart';

abstract class HomeMainState {}

class InitialState extends HomeMainState {}

class ChangBottomState extends HomeMainState {}

class ShopLoadingHomeDateState extends HomeMainState {}

class ShopSuccessHomeDateState extends HomeMainState {}

class ShopErrorHomeDateState extends HomeMainState {}

class ShopLoadingCategoriesDateState extends HomeMainState {}

class ShopSuccessCategoriesDateState extends HomeMainState {}

class ShopErrorCategoriesDateState extends HomeMainState {}

class ChangeSuccessFavoritesState extends HomeMainState {
  final ChangeModelFavourite model  ;

  ChangeSuccessFavoritesState(this.model);

}

class ChangeFavoritesState extends HomeMainState {}

class ChangeErrorFavoritesState extends HomeMainState {}

class GetDataFavouriteSuccessState extends HomeMainState {}

class GetDataFavouriteErrorState extends HomeMainState {}

class GetDataFavouriteLoadingState extends HomeMainState {}

class GetDataUserSuccessState extends HomeMainState {}

class GetDataUserErrorState extends HomeMainState {}

class GetDataUserLoadingState extends HomeMainState {}


class  UpdateLoadingState extends HomeMainState {}

class  UpdateSuccessState extends HomeMainState {}

class UpdateErrorState extends HomeMainState{}

class ChangeColorModeSuccessState extends HomeMainState{}

class ChangeColorModeErrorState extends HomeMainState{}
class LoadChangeColorModeErrorState extends HomeMainState{}

class asss extends HomeMainState{}

