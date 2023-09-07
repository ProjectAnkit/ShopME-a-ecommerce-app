import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UpperButton extends StatelessWidget {
  const UpperButton({super.key, required this.name, required this.buticon});
  final String name;
  final IconData buticon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
      child: Column(
        children: [
          Container(
            height: 40.h,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300),borderRadius: BorderRadius.circular(4.r)),
            child: Center(child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
              child: Row(
                children: [
                  Text(name,style: GoogleFonts.poppins(color: Colors.black),),
                  Icon(buticon,color: Colors.black,)
                ],
              ),
            ),),
          ),
        ],
      ),
    );
  }
}