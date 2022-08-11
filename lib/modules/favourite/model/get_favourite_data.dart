class ModleGetDateFavourite {
  bool? status ;
  ModelDate? data;
  ModleGetDateFavourite.fromJson(Map<String ,dynamic>json){
    status = json['status'] ;
    data =  ModelDate.fromJson(json['data']) ;
  }
}
class ModelDate{
  int? currentPage ;
  List<ModelDataProducts> dateProducts = [] ;
  ModelDate.fromJson(Map<String ,dynamic>json){
    currentPage = json['current_page'] ;
    json['data'].forEach((element){
      dateProducts.add(ModelDataProducts.fromJson(element));
    });
  }
}
class ModelDataProducts{
int? id ;
ModelGetDataProducts? products;
ModelDataProducts.fromJson(Map<String,dynamic>json){
  id = json['id'] ;
  products=  ModelGetDataProducts.fromJson(json['product']);
}
}
class ModelGetDataProducts{

  int? id ;
  dynamic price ;
  dynamic oldPrice ;
  int? discount ;
  String? image ;
  String? name ;
  String? description ;

  ModelGetDataProducts.fromJson(Map<String ,dynamic>json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}