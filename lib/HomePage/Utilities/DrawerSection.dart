import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class DrawerSection extends StatefulWidget {
   const DrawerSection({required this.isHomePage, required this.isHomePagechanged});
   final bool isHomePage;
   final Function(bool) isHomePagechanged;

  @override
  State<DrawerSection> createState() => _DrawerSectionState();
}

class _DrawerSectionState extends State<DrawerSection> {

  bool switchbutton = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 40.h,
        ),

        CircleAvatar(
          backgroundColor: Colors.grey.shade300,
          foregroundImage: const AssetImage("assets/AppProfile.png"),
          maxRadius: 85.r,
        ),

        SizedBox(
          height: 30.h,
        ),

       
        LiteRollingSwitch(
          onTap: () {},
          onDoubleTap: () {},
          onSwipe: () {},
          value: widget.isHomePage,
          textOn: '   BUY',
          textOff: 'SELL   ',
          colorOn: Colors.black,
          colorOff: Colors.grey.shade500,
          iconOn: Icons.shopify_sharp,
          iconOff: Icons.sell,
          textSize: 16.0.sp,
          textOffColor: Colors.white,
          textOnColor: Colors.white,
          onChanged: (bool state) {

           setState(() {
             widget.isHomePagechanged(state);
           });
          },
        ),


        SizedBox(
          height: 60.h,
        ),


        Padding(
          padding: EdgeInsets.only(right: 50.0.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 35.h,
                    width: 35.w,
                    decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Colors.grey.shade300)),
                    child: const Center(child: Icon(Icons.currency_bitcoin,color: Colors.black))),
              
                   SizedBox(
                      width: 20.w,
                    ),
              
                  InkWell(
                    onTap: (){

                    },
                    child: Container(
                      height: 50.h,
                      width: 120.w,
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300),borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text("Donate us",style: GoogleFonts.poppins(color: Colors.black,fontSize: 18),),
                      ),
                    ),
                  ),
                ],
              ),


              SizedBox(
                height: 40.h,
              ),


               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 35.h,
                    width: 35.w,
                    decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Colors.grey.shade300)),
                    child: const Center(child: Icon(Icons.star,color: Colors.black))),
              
                   SizedBox(
                      width: 20.w,
                    ),
              
                  InkWell(
                    onTap: (){
                      
                    },
                    child: Container(
                      height: 50.h,
                      width: 120.w,
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300),borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text("Rate us",style: GoogleFonts.poppins(color: Colors.black,fontSize: 18),),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )

       
      ],
     );
  }
}