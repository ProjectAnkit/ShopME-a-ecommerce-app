import 'package:ecommerce_app/Loading/LoadingServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadingServices().movetoScreen(context);
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [

           Align(
            alignment: Alignment.center,
            child: Center(child: Image(image: AssetImage("assets/Shopmelogo.png"),height: 160.h,width: 160.w,)),
          ),

          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding:  EdgeInsets.only(bottom: 120.0.h),
              child: Text("ProjectAnkit",style: GoogleFonts.poppins(color: Colors.white),),
            ),
          )
           
        ],
      ),
    );
  }
}