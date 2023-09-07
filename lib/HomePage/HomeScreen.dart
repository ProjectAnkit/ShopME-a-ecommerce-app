import 'package:ecommerce_app/HomePage/Utilities/CategorySection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 
  List<String>Banner = ["assets/Offerpng.png","assets/Fridaysale.png","assets/FreeShipping.png"];
  final pagecontroller = PageController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(
            height: 20.h,
          ),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Text(
              "Category",
              style: GoogleFonts.poppins(
                  color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
          ),
          
           SizedBox(
            height: 10.h,
          ),

           const CategoriesSection(),

           SizedBox(
            height: 18.h,
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Text(
              "Updates",
              style: GoogleFonts.poppins(
                  color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
          ),

           SizedBox(
            height: 10.h,
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Stack(
              children: [
                Container(
                  height: 130.h,
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300),borderRadius: BorderRadius.circular(5.r)),
                  child: Stack(
                    children: [
                      PageView.builder(
                        itemCount: 3,
                        controller: pagecontroller,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index){
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: 130.h,
                            decoration: BoxDecoration(color: Colors.grey.shade100,borderRadius: BorderRadius.circular(5.r)),
                            child: Center(
                              child: Image(image: AssetImage(Banner[index]),height: 130.h,)
                            ),
                          );
                        }),

                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0.h,horizontal: 8.w),
                            child: SmoothPageIndicator(
                              controller: pagecontroller,
                              count: 3,
                              axisDirection: Axis.horizontal,
                              effect: const SlideEffect(
                                  spacing: 8.0,
                                  radius: 8.0,
                                  dotWidth: 8.0,
                                  dotHeight: 8.0,
                                  paintStyle: PaintingStyle.stroke,
                                  strokeWidth: 1.5,
                                  dotColor: Colors.grey,
                                  activeDotColor: Colors.black,
                                  ),
                            ),
                          ),
                        ),
                    ],
                  )
                ),               
              ],
            ),
          ),

        ],
      ),
    );
  }
}