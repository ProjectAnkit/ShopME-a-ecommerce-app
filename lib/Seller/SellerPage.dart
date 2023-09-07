import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Loading/LoadingPage.dart';
import 'package:ecommerce_app/Seller/UploadItemPage.dart';
import 'package:ecommerce_app/Seller/Utilis/ProductModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SellerPage extends StatefulWidget {
  const SellerPage({super.key});

  @override
  State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {

  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser;
    return Column(
          mainAxisAlignment: MainAxisAlignment.start, 
          crossAxisAlignment: CrossAxisAlignment.start,              
                  children: [
          
                    SizedBox(
                      height: 20.h,
                    ),


                    Container(
              height: 40.h,
              width: 160.w,
              decoration:  BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30.r),
                      topRight: Radius.circular(30.r))),
              child: Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
                child: Text(
                  "Your Listed Products",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 14.sp),
                ),
              )),
            ),
        
            
        
             SizedBox(
              height: 10.h,
            ),
          
          
          
                    SizedBox(
                      height: 240.h,
                      width: MediaQuery.of(context).size.width,
                      child: StreamBuilder(
                        stream: firestore.collection("Product").where("seller",isEqualTo: user!.phoneNumber).snapshots(),
                        builder: (context,snapshot){
    
                          if(snapshot.connectionState == ConnectionState.waiting)
                          {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context,index){
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
                                  child: Container(
                                    height: 170.h,
                                    width: 120.w,
                                    decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.circular(10.r)),
                                  ),
                                );
                              });
                          }
    
                          else {
                            
                            if(snapshot.hasData){
                              QuerySnapshot usersnapshot = snapshot.data as QuerySnapshot;
    
                            if(usersnapshot.docs.length == 0)
                            {
                               return Center(child: Text("No products yet",style: GoogleFonts.poppins(color: Colors.grey.shade600),),);
                            }
                            else{
                              return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: usersnapshot.docs.length,
                              itemBuilder: (context,index){
    
                                Map<String,dynamic> usermap = usersnapshot.docs[index].data() as Map<String,dynamic>;
                                ProductModel productModel = ProductModel().fromMap(usermap);
    
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: (){

                                          showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text(
                                                "Are you sure, you want to remove this product ?",
                                                style: GoogleFonts.jost(
                                                    color: Colors.black),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    firestore
                                                        .collection("Product")
                                                        .doc(productModel.id)
                                                        .delete();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "remove",
                                                    style: GoogleFonts.jost(
                                                        color: Colors.red),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "cancel",
                                                    style: GoogleFonts.jost(
                                                        color: Colors.blue),
                                                  ),
                                                ),
                                              ],
                                            );
                                          });

                                        },
                                        child: Container(
                                          height: 170.h,
                                          width: 120.w,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300),borderRadius: BorderRadius.circular(10.r)),
                                          child: CachedNetworkImage(imageUrl: productModel.image.toString(),
                                          placeholderFadeInDuration: const Duration(milliseconds: 100),
                                         placeholder: (context, url) => 
                                               Shimmer.fromColors(
                                                   baseColor: Colors.grey.shade300,
                                                   highlightColor: Colors.white60,
                                                                         child: Container(
                                        height: 170.h,
                                        width: 120.w,
                                        decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(10.r)),
                                                                          ),
                                                                       ),),
                                        ),
                                      ),
                                
                                      Text(productModel.name.toString(),style: GoogleFonts.poppins(color: Colors.grey.shade500),overflow: TextOverflow.ellipsis,),
                                      Text("${productModel.price}/-",style: GoogleFonts.poppins(color: Colors.black,fontSize: 15.sp),)
                                    ],
                                  ),
                                );
                              });
                            }
                            }
    
                            else{
                              return Container();
                            }
                          }
    
                        }),
                    ),
          
                    
          
                     SizedBox(
                      height: 20.h,
                    ),
          
          
                    Container(
                      height: 260.h,
                      decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(15.r)),
                      child: Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h,horizontal: 14.w),
                              child: Text("Do you want to list your new product ? click on the button below ",style: GoogleFonts.poppins(color: Colors.white,fontSize: 16.sp),softWrap: true,),
                            ),
                                
                            InkWell(
                              onTap: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=> const UploadItemPage()));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
                                child: Container(
                                  height: 60.h,
                                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(55.r)),
                                  child: Center(
                                    child: Text("Add Product",style: GoogleFonts.poppins(color: Colors.black),),
                                  ),
                                ),
                              ),
                            ),
                                
                            InkWell(
                              onTap: (){
                                
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 8.w),
                                child: Container(
                                  height: 60.h,
                                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(55.r)),
                                  child: Center(
                                    child: Text("Need help ?",style: GoogleFonts.poppins(color: Colors.black),),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
    
    
                     
                     SizedBox(
                      height: 40.h,
                     ),
    
    
                     Container(
                       height: 90.h,
                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(15.r)),
                       child: Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text("No more want to be a seller ? ",style: GoogleFonts.poppins(color: Colors.white,fontSize: 16.sp),),
                             InkWell(
                               onTap: ()async{

                                final user = auth.currentUser;
                             await firestore
                               .collection("User")
                               .doc(user!.phoneNumber)
                                .update({"isSeller": false});

                                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoadingPage()));
                                 
                               },
                               child: Text(" click here ",style: GoogleFonts.poppins(color: Colors.blue,fontSize: 16.sp,fontWeight: FontWeight.w500),)),
                           ],
                         ),
                       ),
                     ),
                  ],
                );
  }
}