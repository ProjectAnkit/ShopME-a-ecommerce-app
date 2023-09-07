import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Loading/LoadingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmSeller extends StatefulWidget {
  const ConfirmSeller({super.key});

  @override
  State<ConfirmSeller> createState() => _ConfirmSellerState();
}

class _ConfirmSellerState extends State<ConfirmSeller> {

  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text("ConfirmSeller",style: GoogleFonts.poppins(color: Colors.white),),
        centerTitle: true,
      ),
      body: Column(
        children: [            
           SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0.w,vertical: 15.h),
            child: Text("Please enter your buisness GST number to confirm you as a Seller",style: GoogleFonts.poppins(color: Colors.black,fontSize: 16.sp),softWrap: true,),
          ),
      
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0.w),
            child: Container(
              height: 60.h,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey,),borderRadius: BorderRadius.circular(8.r),color: Colors.grey.shade200),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0.w),
                child: Center(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.poppins(),
                    decoration: InputDecoration(
                      hintText: "enter GST number",
                      hintStyle: GoogleFonts.poppins(),
                      border: InputBorder.none
                    ),
                  ),
                ),
              ),
            ),
          ),
      
         
         SizedBox(
          height: 20.h,
         ),
      
          ElevatedButton(
            style: ButtonStyle(backgroundColor: const MaterialStatePropertyAll(Colors.black),fixedSize: MaterialStatePropertyAll(Size(140.w, 50.h))),
            onPressed: ()async{
               final user = auth.currentUser;
               await firestore.collection("User").doc(user!.phoneNumber).update({
                "isSeller": true
               });
          
               Timer(const Duration(milliseconds: 500), () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoadingPage()));
                });
      
            }, 
            child: Center(child: Text("confirm",style: GoogleFonts.poppins(color: Colors.white, fontSize: 15.sp),)))
        ],
      ),
    );
  }
}