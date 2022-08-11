class ModelSearch{
  bool? status ;
  ModelDateSearch? data ;
  ModelSearch.fromJson(Map<String,dynamic>json){
    status = json['status'];
    data = ModelDateSearch.fromJson(json['data']) ;
  }
}

class ModelDateSearch{
  int? currentPage ;
  List<ModelData>data=[] ;
  ModelDateSearch.fromJson(Map<String,dynamic>json){
    currentPage = json['current_page'] ;

    json['data'].forEach((element){
      data.add(ModelData.fromJson(element)) ;
    });
  }

}
class ModelData{
  int? id ;
  dynamic price ;
  String? name ;
  String? description ;
  String? image ;
  bool? inFavourite ;


  ModelData.fromJson(Map<String,dynamic>json){
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavourite = json['in_favorites'];
  }

}