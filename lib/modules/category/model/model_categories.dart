class ModelCategories{
  bool? status ;
  ModelDateCategories? data ;
  ModelCategories.fromJson(Map<String,dynamic>json){
    status = json['status'];
    data = ModelDateCategories.fromJson(json['data']) ;
  }
}

class ModelDateCategories{
  int? currentPage ;
  List<ModelData>data=[] ;
  ModelDateCategories.fromJson(Map<String,dynamic>json){
    currentPage = json['current_page'] ;

    json['data'].forEach((element){
      data.add(ModelData.fromJson(element)) ;
    });
  }

}
class ModelData{
  int? id ;
  String? name ;
  String? image ;

  ModelData.fromJson(Map<String,dynamic>json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

}