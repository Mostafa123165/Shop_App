import 'package:dio/dio.dart';

class DioHelper {
  static  Dio? dio ;
  static init(){
    dio = Dio(
        BaseOptions (
          baseUrl:'https://student.valuxapps.com/api/',
          receiveDataWhenStatusError: true,
        ),
    );
  }


  static Future<Response> getDate({
     required String methodUrl ,
     Map<String,dynamic>?queries,
     String? token ,
     String lang = 'en',
  }) async
  {
    dio?.options.headers = {
      'Content-Type':'application/json' ,
      'lang':lang ,
      'Authorization':token??"" ,
    };

    return await dio!.get(
      methodUrl,queryParameters:queries,
    );
  }

  static Future<Response> posDate({
     required String url ,
     required Map<String, dynamic> data,
     Map<String,dynamic>?queries,
     String lang  ='en',
     String? token ,
  })async{
     dio?.options.headers = {
      'Content-Type':'application/json' ,
      'lang':lang ,
      'Authorization':token??"" ,
      };

      return await dio!.post(
        url,
        queryParameters:queries,
        data:data,
    );
  }

  static Future<Response> putDate({
    required String url ,
    required Map<String, dynamic> data,
    Map<String,dynamic>?queries,
    String lang  ='en',
    String? token ,
  })async{
    dio?.options.headers = {
      'Content-Type':'application/json' ,
      'lang':lang ,
      'Authorization':token??"" ,
    };

    return await dio!.put(
      url,
      queryParameters:queries,
      data:data,
    );
  }

}