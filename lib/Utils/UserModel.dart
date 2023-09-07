// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String? name;
  String? phoneNumber;
  String? email;
  bool? isSeller;
  UserModel({
     this.name,
     this.phoneNumber,
     this.email,
     this.isSeller
  });


  UserModel fromMap(Map<String,dynamic> map)
  {
    name = map["name"];
    phoneNumber = map["phoneNumber"];
    email = map["email"];
    isSeller = map["isSeller"];
    return UserModel(name: name, phoneNumber: phoneNumber, email: email,isSeller: isSeller);
  }


  Map<String,dynamic> toMap(){
    return {
       "name" : name,
       "phoneNumber" : phoneNumber,
       "email" : email,
       "isSeller" : isSeller,
    };
  }
}
