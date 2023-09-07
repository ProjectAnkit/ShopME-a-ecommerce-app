import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyInputField extends StatelessWidget {
  const MyInputField({super.key, required this.hint, required this.textcontroller, required this.length, required this.maxlines});
  final String hint;
  final TextEditingController textcontroller;
  final int maxlines;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0.h),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: TextFormField(
              cursorColor: Colors.black,
              maxLength: length,
              maxLines: maxlines,
              style: GoogleFonts.poppins(),
              controller: textcontroller,
              decoration: InputDecoration(
                counterText: "",
                hintText: hint,
                hintStyle: GoogleFonts.poppins(),
                border: InputBorder.none),
            ),
          ),
        ),
      ),
    );
  }
}





