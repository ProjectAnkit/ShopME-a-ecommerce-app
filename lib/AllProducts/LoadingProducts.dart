
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
class LoadingProducts extends StatefulWidget {
  const LoadingProducts({super.key});


  @override
  State<LoadingProducts> createState() => _LoadingProductsState();
}

class _LoadingProductsState extends State<LoadingProducts> {

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Colors.white60,
      baseColor: Colors.grey.shade300,
      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 220.h,
                            decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.circular(10.r)),
                          ),
                      
                      
                          SizedBox(
                            height: 10.h,
                          ),
                       
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 20.h,
                                      width: 80.w,
                                      decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.circular(4.r)),
                                    ),
    
                                    SizedBox(
                                      height: 8.h,
                                    ),
    
                                    Container(
                                      height: 10.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.circular(4.r)),
                                    ),
                                  ],
                                ),
    
                                Container(
                                  height: 30.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.circular(4.r)),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
    );
  }
}



