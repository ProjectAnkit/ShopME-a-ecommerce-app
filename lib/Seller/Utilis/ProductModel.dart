// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? id;
  String? name;
  String? desc;
  String? details;
  String? price;
  String? type;
  String? image;
  List? images;
  Timestamp? uploadTime;
  ProductModel({
    this.id,
    this.name,
    this.desc,
    this.details,
    this.price,
    this.type,
    this.image,
    this.images,
    this.uploadTime,
  });


  ProductModel fromMap(Map<dynamic,dynamic> map){
    id = map["id"];
    name = map["ProductName"];
    desc = map["ShortDesc"];
    details = map["ProductDetails"];
    price = map["Price"];
    image = map["mainimage"];
    type = map["Option"];
    uploadTime = map["UploadTime"];
    images = map["Images"];
    return ProductModel(desc: desc,details: details,image: image,name: name,price: price,type: type,id: id,images: images,uploadTime: uploadTime);
  }


  Map<String,dynamic> toMap(){
    return {
      'id': id,
      'ProductName': name,
      'ShortDesc': desc,
      'ProductDetails': details,
      'Price': price,
      'mainimage': image,
      "Option" : type,
      "UploadTime": uploadTime,
      "Images": images
    };
  }
}
