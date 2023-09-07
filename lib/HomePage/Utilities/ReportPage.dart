import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  TextEditingController reportcontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Help center ",style: GoogleFonts.poppins(color: Colors.white),),
            const Icon(Icons.headset_mic_outlined),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: EdgeInsets.only(top: 20.h,bottom: 5.h,left: 15.w,right: 15.w),
            child: Text("Report your issue here :",style: GoogleFonts.poppins(color: Colors.black,fontSize: 18.sp),),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400),borderRadius: BorderRadius.circular(10.r)),
              child: Center(child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w,vertical: 8.h),
                child: TextFormField(
                  controller: reportcontroller,
                  maxLines: 5,
                  maxLength: 180,
                  cursorColor: Colors.black,
                  style: GoogleFonts.poppins(color: Colors.black),
                  decoration: const InputDecoration(
                    border: InputBorder.none
                  ),
                ),
              ))),
          ),

         Center(
           child: Padding(
             padding: EdgeInsets.symmetric(horizontal: 8.0.w,vertical: 8.h),
             child: ElevatedButton(
              style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black)),
              onPressed: ()async{
              
              await firestore.collection("Reports").doc(user!.phoneNumber).set({
                "Problem": reportcontroller.text.toString()
              });

              reportcontroller.clear();
                    
             }, child: Text("submit",style: GoogleFonts.poppins(color: Colors.white),)),
           ),
         )
        ],
      ),
    );
  }
}