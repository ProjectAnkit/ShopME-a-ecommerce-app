import 'dart:async';

import 'package:ecommerce_app/HomePage/HomePage.dart';
import 'package:ecommerce_app/Utils/LoadingDialog.dart';
import 'package:ecommerce_app/Utils/ToastMessages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CodePage extends StatefulWidget {
  const CodePage({super.key, required this.verificationId,});
  final String verificationId;


  @override
  State<CodePage> createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {

  bool buttonpressed = false;
  TextEditingController codecontroller = TextEditingController();
  final auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),

      body: Column(
        children: [

          SizedBox(
            height: 60.h,
          ),

          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.0.w),
            child: PinCodeTextField(
              controller: codecontroller,
              textStyle: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500),
              enabled: true,
              animationType: AnimationType.fade,   
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                fieldHeight: 70.h,
                fieldWidth: 45.w,    
                borderRadius: BorderRadius.circular(7.r),  
                inactiveColor: Colors.grey,
                selectedColor: Colors.grey,
                activeColor: Colors.black,
                borderWidth: 2.w,   
              ),
              appContext: context, 
              length: 6, 
              onChanged: (value){
          
              }),
          ),
          
          
          SizedBox(
            height: 10.h,
          ),

          InkWell(
              onTap: (){
                 
                 submit(widget.verificationId);
                 
              },
               child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 60.h,
                width: 130.w,
                decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(55)
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
                child: Center(child: Text("Submit",style: GoogleFonts.poppins(color: Colors.white,fontSize: 16.sp,fontWeight: FontWeight.w400),)),
               ),
             ),
        ],
      ),
    );
  }


  Future<void> submit(String verificationId)async{

    Loadingdialog().showloadingdialog(context);

    setState(() {
      buttonpressed = true;
    });

    try{
       
       final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: codecontroller.text.toString());

        await auth.signInWithCredential(credential).then((value) {
          Navigator.pop(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
        }).onError((error, stackTrace) {
           Navigator.pop(context);  
          setState(() {
            buttonpressed = false;
          });

          toastmessage().showerror(error.toString());
        });
    }

    catch(e){
      setState(() {
        buttonpressed = false;
      });
      Navigator.pop(context);
      toastmessage().showerror(e.toString());
    }
  }
}