class ModelShop {
    bool? status ;
    GetDateHome? data;

    ModelShop.fromJson(Map<String,dynamic>json){
      status = json['status'] ;
      data =  GetDateHome.fromJson(json['data']) ;
    }

}

class GetDateHome{

   List<GetDateBanners> banners=[] ;
   List<GetDateProducts> products=[] ;

   GetDateHome.fromJson(Map<String,dynamic>json){

     json['banners'].forEach((element){
       banners.add(GetDateBanners.fromJson(element)) ;
     });

     json['products'].forEach((element){
       products.add(GetDateProducts.fromJson(element)) ;
     });

  }

}

class GetDateBanners {

  int? id ;
  String? image ;

  GetDateBanners.fromJson(Map<String,dynamic>json){
    id = json['id'] ;
    image = json['image'] ;
  }

}

class GetDateProducts{
  int? id ;
  dynamic  price ;
  dynamic  oldPrice ;
  int? discount ;
  String? image ;
  String? nameProduct ;
  bool? inFavorites ;

  GetDateProducts.fromJson(Map<String,dynamic>json){
    id = json['id'] ;
    price = json['price'] ;
    oldPrice = json['old_price'] ;
    discount = json['discount'] ;
    image = json['image'] ;
    nameProduct = json['name'] ;
    inFavorites = json['in_favorites'] ;
  }

}
