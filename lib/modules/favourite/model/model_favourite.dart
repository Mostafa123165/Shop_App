class ChangeModelFavourite {
  bool? status ;
  String? message ;
  ChangeModelFavourite.fromJson(Map<String,dynamic>json){
    status = json['status'] ;
    message = json['message'] ;
  }

}