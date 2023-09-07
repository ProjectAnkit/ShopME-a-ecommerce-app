import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/ProductPage/ProductPage.dart';
import 'package:ecommerce_app/Seller/Utilis/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class LoadedProducts extends StatefulWidget {
  const LoadedProducts({super.key, required this.productmodel});
  final ProductModel productmodel;

  @override
  State<LoadedProducts> createState() => _LoadedProductsState();
}

class _LoadedProductsState extends State<LoadedProducts> {

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductPage(Productid: widget.productmodel.id.toString(),)));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 220.h,
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300),borderRadius: BorderRadius.circular(10.r)),
                            child: Center(
                              child: CachedNetworkImage(
                                   imageUrl: widget.productmodel.image.toString(),
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
                            title: Text(widget.productmodel.name.toString(),style: GoogleFonts.poppins(),overflow: TextOverflow.ellipsis),
                            subtitle: Text(widget.productmodel.desc.toString(),style: GoogleFonts.poppins(),overflow: TextOverflow.ellipsis),
                            trailing: Text("${widget.productmodel.price}/-",style: GoogleFonts.poppins(color: Colors.black),),
                          )
                        ],
                      ),
                    );
  }
}