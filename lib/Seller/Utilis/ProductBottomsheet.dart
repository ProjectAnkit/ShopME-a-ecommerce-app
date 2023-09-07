import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Seller/Utilis/CustomInputField.dart';
import 'package:ecommerce_app/Utils/ToastMessages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';


Future <dynamic> showproductSheet(BuildContext context,File? image1,File? image2,File? image3)async{

  TextEditingController prodnamecontroller = TextEditingController();
  TextEditingController prodsubnamecontroller = TextEditingController();
  TextEditingController proddesccontroller = TextEditingController();
  TextEditingController prodpricecontroller = TextEditingController();

  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;

  List<String>Options = ["Upperwear","Lowerwear","Footwear","Utensils","Appliances","Jewellery","Electronics","Travel","Mobile"];

  String Option = "Upperwear";


   Future UploadProduct()async{
   
    Navigator.pop(context);
    showDialog(   
      barrierDismissible: false, 
      context: context, 
      builder: (context){
        return  const AlertDialog(

          actions: [

            Column(
              children: [
                SpinKitCircle(color: Colors.deepPurple,),
              ],
            ),
            
          ],
        );
      });
    final user = auth.currentUser;

    try{
      
      //For image 1
      final imageref1 = storage.ref(DateTime.now().millisecondsSinceEpoch.toString());
      await imageref1.putFile(image1!.absolute);

      final url1 = await imageref1.getDownloadURL();
      

      //For image 2
      final imageref2 = storage.ref(DateTime.now().millisecondsSinceEpoch.toString());
      await imageref2.putFile(image2!.absolute);

      final url2 = await imageref2.getDownloadURL();


      //For image 3
      final imageref3 = storage.ref(DateTime.now().millisecondsSinceEpoch.toString());  
      await imageref3.putFile(image3!.absolute);
      
      final url3 = await imageref3.getDownloadURL();

      final timestamp = Timestamp.now();
      final productid = DateTime.now().millisecondsSinceEpoch.toString();

      await firestore.collection("Product").doc(productid).set({
        "seller": user!.phoneNumber,
        "id": productid,
        "ProductName": prodnamecontroller.text.toString(),
        "ShortDesc": prodsubnamecontroller.text.toString(),
        "ProductDetails": proddesccontroller.text.toString(),
        "Price": prodpricecontroller.text.toString(),
        "mainimage": url1,
        "Option": Option,
        "UploadTime" : timestamp,
        "Images": [
          url1,url2,url3
        ]
      });

       Navigator.pop(context);
       Navigator.pop(context);
       toastmessage().showsuccess("Successfully uploaded");
    }



    // ignore: empty_catches
    catch(e){ 
      toastmessage().showerror(e.toString());

      Navigator.pop(context);
    }

    }


  

  await showModalBottomSheet(
    context: context, 
    enableDrag: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context){
       
      return Builder(
        builder: (context) {
          return Container(

                    height: MediaQuery.of(context).size.height *0.65,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.deepPurple,borderRadius: BorderRadius.only(topLeft: Radius.circular(25.r),topRight: Radius.circular(25.r))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Column(
                        children: [
                      
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.0.h),
                            child: Container(
                              height: 4.h,
                              width: 60.w,
                              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10.r)),
                            ),
                          ),
                      
                          
                          MyInputField(hint: "Product name", textcontroller: prodnamecontroller, length: 20,maxlines: 1,),
                      
                          MyInputField(hint: "Short description", textcontroller: prodsubnamecontroller, length: 50,maxlines: 2,),
                      
                          MyInputField(hint: "Product details", textcontroller: proddesccontroller, length: 320, maxlines: 4),
                      
                          MyInputField(hint: "Price", textcontroller: prodpricecontroller, length: 6,maxlines: 1,),
          
                          Container(
                            height: 50.h,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10.r)),
                            child: Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Type :",style: GoogleFonts.poppins(color: Colors.grey.shade700),),
                                  DropdownButton(
                                    value: Option,
                                    items: Options.map((String e) {
                                      return DropdownMenuItem(
                                        onTap: (){
                                          Option = e.toString();
                                        },
                                        value: e,
                                        child: Text(e,style: GoogleFonts.poppins(color: Colors.grey),));
                                    }).toList(), 
                                    onChanged: (value){
                                      Option = value.toString();
                                    }),
                                ],
                              ),
                            ),
                          ),
          
                          SizedBox(
                            height: 15.h,
                          ),
          
                          
                      
                          InkWell(
                      onTap: () {
                        
                        UploadProduct();
                                           
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 60.h,
                        width: 200.w,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(55.r),
                          boxShadow: const [
                            BoxShadow(
                                    offset: Offset(1.5, 1.5),
                                    color: Colors.black87,
                                    spreadRadius: 2,
                                    blurRadius: 1,
                                  ),
                          ],
                        ),
                        child: Center(
                            child: Text(
                          "Upload Product",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400),
                        )),
                      ),
                    ),
                        ],
                      ),
                    ),
                  );
        }
      );
    });
}