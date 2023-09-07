import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Seller/Utilis/ProductModel.dart';


final firestore = FirebaseFirestore.instance;

Future<ProductModel> getProduct(String productid)async{
 
   final document = await firestore.collection("Product").doc(productid).get();

   Map<String,dynamic> productmap = document.data() as Map<String,dynamic>;
   ProductModel productModel = ProductModel().fromMap(productmap);

   return productModel;
}


