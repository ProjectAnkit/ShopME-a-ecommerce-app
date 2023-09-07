import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/CartPage/GetProduct.dart';
import 'package:ecommerce_app/ProductPage/ProductPage.dart';
import 'package:ecommerce_app/Seller/Utilis/ProductModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {

  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,   
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

           SizedBox(
            height: 10.h,
          ),

          Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.w,vertical: 4.h),
                      child: Text("My Wishlist",style: GoogleFonts.poppins(color: Colors.black,fontSize: 25.sp,fontWeight: FontWeight.w400),),
                    ),
          
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                      child: Text("Items you liked will be saved here",style: GoogleFonts.poppins(color: Colors.grey,fontSize: 15.sp,fontWeight: FontWeight.w400),),
                    ),
                  ],
                ),
          
          
                 Icon(Icons.favorite,color: Colors.black,size: 30.w,),
              ],
            ),
          ),

           SizedBox(
            height: 30.h,
          ),

          const Divider(color: Colors.grey,thickness: 0.68),
          
          
          Expanded(
            child: StreamBuilder(
              stream: firestore
                  .collection("User")
                  .doc(user!.phoneNumber)
                  .collection("wishlist")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else {
                  if (snapshot.hasData) {
                    QuerySnapshot datasnapshot = snapshot.data as QuerySnapshot;
                    return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 370),
                        itemCount: datasnapshot.docs.length,
                        itemBuilder: (context, index) {
                          String productid =
                              datasnapshot.docs[index]["id"].toString();
                            
                          return FutureBuilder(
                              future: getProduct(productid),
                              builder: ((context, asyncsnapshot) {
                                if (asyncsnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container();
                                } else {
                                  if (asyncsnapshot.hasData) {
                                    ProductModel productModel =
                                        asyncsnapshot.data as ProductModel;
                            
                                    return Padding(
                                      padding: EdgeInsets.all(8.0.w),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: (){

                                              firestore.collection("User").doc(user.phoneNumber).collection("wishlist").doc(productid).delete();
                                              
                                            },
                                            child: Container(
                                              height: 30.h,
                                              width: 40.w,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors
                                                          .grey.shade300),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r)),
                                              child:  Center(
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.grey,
                                                  size: 20.w,
                                                ),
                                              ),
                                            ),
                                          ),


                                           SizedBox(
                                            height: 2.h,
                                          ),


                                          InkWell(
                                                              onTap: (){
                                                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductPage(Productid: productModel.id.toString(),)));
                                                              },
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                children: [
                                                                 
                                                                  Container(
                                                                    height: 220.h,
                                                                    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300),borderRadius: BorderRadius.circular(10.r)),
                                                                    child: Center(
                                                                      child: CachedNetworkImage(
                                                                           imageUrl: productModel.image.toString(),
                                                                           placeholderFadeInDuration: const Duration(milliseconds: 100),
                                                                           placeholder: (context, url) => 
                                                                           Shimmer.fromColors(
                                                                                                baseColor: Colors.grey.shade300,
                                                                                                highlightColor: Colors.white60,
                                                                                                 child: Container(
                                                                                                    height: 220.h,
                                                                                                    decoration: BoxDecoration(
                                                                                                    color: Colors.grey.shade300,
                                                                                                    borderRadius: BorderRadius.circular(10.r)),
                                                                                                  ),
                                                                           ),
                                                                          ),
                                                                    ),
                                                                  ),
                                                                                                                  
                                                                                                                  
                                                                   SizedBox(
                                                                    height: 5.h,
                                                                  ),
                                                                                                                  
                                                                  ListTile(
                                                                    title: Text(productModel.name.toString(),style: GoogleFonts.poppins(),overflow: TextOverflow.ellipsis),
                                                                    subtitle: Text(productModel.desc.toString(),style: GoogleFonts.poppins(),overflow: TextOverflow.ellipsis),
                                                                    trailing: Text(productModel.price.toString(),style: GoogleFonts.poppins(color: Colors.black),),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                        ],
                                      ),
                                    );
          
                    }      
                    
                          else {
                                    return Container();
                                  }
                                }
                              }));
                        });
                  } else {
                    return Container();
                  }
                }
              }),
          ),
        ],
      ),
    );
  }
}