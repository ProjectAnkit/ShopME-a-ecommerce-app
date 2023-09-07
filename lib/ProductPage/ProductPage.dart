import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/ProductPage/Utilis/BottomButtons.dart';
import 'package:ecommerce_app/ProductPage/Utilis/TopIcons.dart';
import 'package:ecommerce_app/Seller/Utilis/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.Productid, });
  final String Productid;
  

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: StreamBuilder(
              stream: firestore.collection("Product").where("id",isEqualTo: widget.Productid).snapshots(),
              builder: (context,snapshot){

                if(snapshot.connectionState == ConnectionState.waiting)
                {
                  return const CircularProgressIndicator(color: Colors.deepPurple,);
                }

                else{
                   QuerySnapshot productsnapshot = snapshot.data as QuerySnapshot;

                     if(snapshot.hasData)
                     {
                        Map<dynamic,dynamic> productmap = productsnapshot.docs[0].data() as Map<dynamic,dynamic>;
                        ProductModel productModeL = ProductModel().fromMap(productmap);

                        return Stack(
                                 children: [


            //Lower Violet Part of Screen

             Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height*0.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.only(topLeft: Radius.circular(25.r),topRight: Radius.circular(25.r))),
                child:  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.0.w,vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                       SizedBox(
                        height: 30.h,
                      ),

                      Text(productModeL.name.toString(),style: GoogleFonts.poppins(color: Colors.white,fontSize: 22.sp),),
                      Text(productModeL.desc.toString(),style: GoogleFonts.poppins(color: Colors.white70),),

                      SizedBox(
                        height: 30.h,
                      ),

                      Text("Description",style: GoogleFonts.poppins(color: Colors.white,fontSize: 22.sp),),
                      Text(productModeL.details.toString(),style: GoogleFonts.poppins(color: Colors.white70),softWrap: true,),

                       SizedBox(
                        height: 20.h,
                      ),

                      
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text("Price",style: GoogleFonts.poppins(color: Colors.white,fontSize: 26.sp),),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.0.w),
                            child: Column(
                              children: [
                                Container(
                                  height: 50.h,
                                  decoration: BoxDecoration(shape: BoxShape.rectangle,border: Border.all(color: Colors.grey),borderRadius: const BorderRadius.horizontal(left: Radius.elliptical(40, 20))),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 6.0.w),
                                      child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0.w),
                                          child: Container(
                                            height: 10.h,
                                            width: 10.w,
                                            decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle,border: Border.all(color: Colors.white)),
                                          ),
                                        ),
                                        Text("${productModeL.price}/-",style: GoogleFonts.poppins(color: Colors.white,fontSize: 26.sp),),
                                      ],
                                      ),
                                    ))),
                              ],
                            ),
                          ),
                       ],
                     ),
                    ],
                  ),
                ),
              ),
            ),




            // Upper Navigator and Like Buttons

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                   Padding(
                   padding: EdgeInsets.only(left: 4.w,right: 10.w,top: 4.h),
                   child: TopIcons(productid: widget.Productid.toString(),)
                 ),



                  //Product Image

                  CarouselSlider(                                                                      
                    items: productModeL.images?.map((i) {
                      return Builder(
                        builder: (BuildContext context){
                          return SizedBox(
                            height: 290.h,
                            width: 290.w,
                            child: Center(
                              child: CachedNetworkImage(
                                imageUrl: i,
                                placeholder: (context, url) {
                                  return const CircularProgressIndicator(color: Colors.black,);
                                },),
                            ),
                          );
                        });
                    }).toList(), 
                    options: CarouselOptions(height: 400,enlargeCenterPage: true,enlargeStrategy: CenterPageEnlargeStrategy.zoom,enlargeFactor: 0.6,enableInfiniteScroll: true))
              ],
            ),


            
            //Bottom Buy And Cart Buttons

             Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0.w,vertical: 16.h),
                child: BottomButtons(productid: widget.Productid,price: productModeL.price.toString(),)
              ),
            )
          ],
        );
                     }

                     else{
                      return Container();
                     }
                }
              }),
      ),
    );
  }
}



















