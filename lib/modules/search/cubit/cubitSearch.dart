import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componens/componens.dart';
import 'package:shopapp/modules/search/cubit/state.dart';
import 'package:shopapp/modules/search/modelSearch.dart';
import 'package:shopapp/network/dio_helper.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit() : super(InitialSearchState());

  static SearchCubit get(context) => BlocProvider.of(context) ;
  ModelSearch? modelSearch;
  void search(String text) {
    emit(LoadingSearchState());
    DioHelper.posDate(
        url: 'products/search',
        token: token,
        data: {
          "text": text,
        }
    ).then((value) {
      modelSearch = ModelSearch.fromJson(value.data);
      print(modelSearch!.data!.data.length);
      emit(SuccessSearchState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorSearchState());
    });
  }
}