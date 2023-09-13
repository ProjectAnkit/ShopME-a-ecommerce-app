import 'dart:async';

import 'package:ecommerce_app/Login/CodePage.dart';
import 'package:ecommerce_app/Utils/LoadingDialog.dart';
import 'package:ecommerce_app/Utils/ToastMessages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  TextEditingController mobcontroller = TextEditingController();
  bool buttonpressed = false;
  final auth = FirebaseAuth.instance;



  Future<void>login()async{
    Loadingdialog().showloadingdialog(context);
    setState(() {
      buttonpressed = true;
    });

     try{
       
       await auth.verifyPhoneNumber(
        phoneNumber: "+91${mobcontroller.text}",
         verificationCompleted: (_){
               setState(() {
                 buttonpressed = false;
                 mobcontroller.clear();
               });    
         },
         verificationFailed: (e){
           Navigator.pop(context);  
           setState(() {
             buttonpressed = false;
           });
          toastmessage().showerror(e.toString());
         }, 
         codeSent: (verificationId,code){    
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CodePage(verificationId: verificationId,)));
          toastmessage().showsuccess("code sent successfully");    
         }, 
         codeAutoRetrievalTimeout: (e){
          setState(() {
            buttonpressed = false;
          });
         });


     }catch(e){
         setState(() {
           buttonpressed = false;
         });
         Navigator.pop(context);
         toastmessage().showerror(e.toString());
     }
     
    
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      body: SingleChildScrollView(
        child: Column(
          children: [
             SizedBox(
              height: 30.h,
            ),
        
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              child:  Center(
                child: SizedBox(
                  height: 260.h,
                  width: 260.w,
                  child: Image(image: AssetImage("assets/Shopping.png"))),
              ),
            ),
            
        
             SizedBox(
              height: 30.h,
            ),
        
        
            Text("Welcome dear ! , login to continue",style: GoogleFonts.poppins(color: Colors.black,fontSize: 22.sp),softWrap: true,textAlign: TextAlign.center,),
        
             SizedBox(
              height: 30.h,
            ),
        
             
            
             Padding(
               padding:  EdgeInsets.symmetric(vertical: 8.0.h,horizontal: 8.0.w),
               child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(5.r)),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 12.0.w,vertical: 6.h),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 20.0.w),
                        child: Text("+91",style: GoogleFonts.poppins(color: Colors.black,fontSize: 18.sp),),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.7,
                        child: Center(
                          child: TextFormField(
                            controller: mobcontroller,
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            expands: false,
                            cursorColor: Colors.black,
                            style: GoogleFonts.poppins(color: Colors.black,fontSize: 18.sp),
                            decoration: InputDecoration( 
                              counterText: "",
                              hintText: "Enter your Phone number",
                              hintStyle: GoogleFonts.poppins(fontSize: 16.sp),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
               ),
             ),
             
      
              SizedBox(
              height: 20.h,
             ),
             
      
      
             InkWell(
              onTap: ()async{
                 
                    login();
      
              },
               child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 60.h,
                width: 130.w,
                decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(55.r)
                ,boxShadow: [
                  buttonpressed?
                  const BoxShadow()
                  :
                  const BoxShadow(            
                    offset: Offset(1.5, 1.5),
                    color: Colors.black87,
                    spreadRadius: 2,
                    blurRadius: 1,
                  ), 
                ],),
                child: Center(child: Text("login",style: GoogleFonts.poppins(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w400),)),
               ),
             ),
      
             
              SizedBox(
              height: 20.h,
             ),
      
      
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text("Don't want to login now ?",style: GoogleFonts.poppins(color: Colors.black,fontSize: 16.sp),),
                 InkWell(
                  onTap: (){
                    
                  },
                  child: Text(" Skip",style: GoogleFonts.poppins(color: Colors.blue,fontSize: 16.sp),)),
               ],
             )
          ],
        ),
      ),
    );
  }
  
}