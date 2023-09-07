import 'dart:io';
import 'package:ecommerce_app/Seller/Utilis/ProductBottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class UploadItemPage extends StatefulWidget {
  const UploadItemPage({super.key});

  @override
  State<UploadItemPage> createState() => _UploadItemPageState();
}

class _UploadItemPageState extends State<UploadItemPage>with WidgetsBindingObserver{

  File? image1;
  File? image2;
  File? image3;
  final picker1 = ImagePicker();
  final picker2 = ImagePicker();
  final picker3 = ImagePicker();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("UploadItem",style: GoogleFonts.poppins(color: Colors.white),),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [         
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h,horizontal: 8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: ()async{
                    
                      final imagepath1 =
                          await picker1.pickImage(source: ImageSource.gallery,imageQuality: 30);
                
                      if (imagepath1 != null) {
                        setState(() {
                        image1 = File(imagepath1.path);
                      });
                      }
                      else{
                        image1 = null;
                      }
                    },
                  child: Container(
                    height: 160.h,
                    width: MediaQuery.of(context).size.width*0.25,
                    decoration: BoxDecoration(color: Colors.transparent,border: Border.all(color: Colors.grey.shade400)),
                    child: Center(
                      child: image1!=null?Image(image: FileImage(image1!.absolute),fit: BoxFit.cover,) : Text("tap to add image",style: GoogleFonts.poppins(color: Colors.grey.shade400,fontSize: 12.sp),textAlign: TextAlign.center,),
                    ),
                  ),
                ),
                
                
                InkWell(
                  onTap: ()async{
                    
                      final imagepath2 =
                          await picker2.pickImage(source: ImageSource.gallery,imageQuality: 30);
                
                      if (imagepath2 != null) {
                        setState(() {
                        image2 = File(imagepath2.path);
                      });
                      }
                      else{
                        image2=null;
                      }
                    },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.0.w),
                    child: Container(
                      height: 260.h,
                      width: MediaQuery.of(context).size.width*0.40,
                      decoration: BoxDecoration(color: Colors.transparent,border: Border.all(color: Colors.grey.shade400)),
                      child: Center(
                        child: image2!=null?Image(image: FileImage(image2!.absolute),fit: BoxFit.cover,) : Text("tap to add image",style: GoogleFonts.poppins(color: Colors.grey.shade400,fontSize: 12.sp),),
                      ),
                    ),
                  ),
                ),
                
                
                InkWell(
                  onTap: ()async{
                    
                      final imagepath3 =
                         await picker3.pickImage(source: ImageSource.gallery,imageQuality: 30);
                
                      if (imagepath3 != null) {
                        setState(() {
                        image3 = File(imagepath3.path);
                      });
                      }
                      else{
                        image3 = null;
                      }
                    },
                  child: Container(
                    height: 160.h,
                    width: MediaQuery.of(context).size.width*0.25,
                    decoration: BoxDecoration(color: Colors.transparent,border: Border.all(color: Colors.grey.shade400)),
                    child: Center(
                      child: image3!=null?Image(image: FileImage(image3!.absolute),fit: BoxFit.cover,) : Text("tap to add image",style: GoogleFonts.poppins(color: Colors.grey.shade400,fontSize: 12.sp),textAlign: TextAlign.center,),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
      
      
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text("Remember !",style: GoogleFonts.poppins(color: Colors.black,fontSize: 18.sp),),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text("1. Uploaded product image should be in cutout.",style: GoogleFonts.poppins(color: Colors.grey.shade600,fontSize: 14.sp),softWrap: true,),
                  Text("2. Upload product image should be in png format.",style: GoogleFonts.poppins(color: Colors.grey.shade600,fontSize: 14.sp),softWrap: true,),
                  Text("3. Uploaded product image should be clear.",style: GoogleFonts.poppins(color: Colors.grey.shade600,fontSize: 14.sp),softWrap: true,),
                  Text("4. Uploaded product image should be related to that product.",style: GoogleFonts.poppins(color: Colors.grey.shade600,fontSize: 14.sp),softWrap: true,),
                  Text("5. Uploaded product image size should less than 5 mb.",style: GoogleFonts.poppins(color: Colors.grey.shade600,fontSize: 14.sp),softWrap: true,),
                  Text("6. Uploaded product image should be in Boxfit.",style: GoogleFonts.poppins(color: Colors.grey.shade600,fontSize: 14.sp),softWrap: true,),
              ],
            ),
          ),
      
          const Expanded(child: Column()),
      
      
          Padding(
            padding: EdgeInsets.symmetric(vertical: 14.0.h),
            child: Center(
              child: Column(
                children: [
                  Text("Tap to proceed",style: GoogleFonts.poppins(color: Colors.black,fontSize: 12.sp),),
                  SizedBox(
                    height: 4.h,
                  ),
                  IconButton(onPressed: ()async{
                    await showproductSheet(context,image1,image2,image3);
                  }, icon: Icon(Icons.keyboard_double_arrow_up,color: Colors.black,size: 40.w,),),
                ],
              ),
            ),
          )
         
        ],
      ),
    );
  }
}










