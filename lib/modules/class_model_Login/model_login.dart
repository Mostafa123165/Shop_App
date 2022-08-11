class LoginModel_RegisterModel {
  bool? status;

  String? message;

  UserDate? data;

  LoginModel_RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserDate.fromJson(json['data']) : null;
  }
}

class UserDate {
  int? id;

  String? name;

  String? email;

  String? phone;

  String? image;

  String? token;

  UserDate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
  }
}

/*
class LoginModel
{
  bool? status;
  String? message;
  UserData? data;
  LoginModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData
{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

  UserData.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
  }
}*/
