import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/HomePage/Utilities/ReportPage.dart';
import 'package:ecommerce_app/Seller/ConfirmSeller.dart';
import 'package:ecommerce_app/Login/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.name, required this.phoneNumber, required this.email});
  final String name;
  final String phoneNumber;
  final String email;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
             
             Padding(
               padding: EdgeInsets.all(14.0.w),
               child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    foregroundImage: AssetImage("assets/AppProfile.png"),
                    maxRadius: 55.r,
                  ),
                 
      
                   SizedBox(
                    width: 30.w,
                  ),
      
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.name,style: GoogleFonts.poppins(color: Colors.black,fontSize: 18.sp),),
                      Text(widget.phoneNumber,style: GoogleFonts.poppins(color: Colors.grey),),
                      widget.email==""?InkWell(
                        onTap: (){

                        },
                        child: Text("add email",style: GoogleFonts.poppins(color: Colors.blue),)):Text(widget.email.toString(),style: GoogleFonts.poppins(color: Colors.black),),
      
                       SizedBox(
                        height: 3.h,
                      ),
      
                      InkWell(
                        onTap: (){
                          
                        },
                        child: Text("change details",style: GoogleFonts.poppins(color: Colors.blue),)),
                    ],
                  )
                ],
               ),
             ),
      
             SizedBox(
              height: 20.h,
             ),
 
            

             MyProfileOption(title: "Upgrade to Seller account", subtitle: "become a seller", settingicon: Icons.sell_outlined, ontap: (){
             
              Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConfirmSeller()));
             }),
      
             MyProfileOption(ontap: (){},settingicon: Icons.person,title: "Personal details",subtitle: "name, phone, email"),

             MyProfileOption(ontap: (){}, settingicon: Icons.work_history_sharp,title: "My Orders",subtitle: "see your all order details",),

             MyProfileOption(title: "Refer your friend", subtitle: "refer and earn upto 10k rewards", settingicon: Icons.handshake, ontap: (){}),

             MyProfileOption(title: "Help Center", subtitle: "get help from our 24x7 customer support", settingicon: Icons.headset_mic, ontap: (){
 
             Navigator.push(context, MaterialPageRoute(builder: (context)=> ReportPage()));

             }),

             MyProfileOption(title: "Log out", subtitle: "log out account from this device", settingicon: Icons.logout_outlined, 
             ontap: (){
               auth.signOut();
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
             }),




            Divider(thickness: 0.8,color: Colors.grey.shade300,),

          ],
        ),
      ),
    );
  }
}


class MyProfileOption extends StatelessWidget {
  const MyProfileOption({super.key, required this.title, required this.subtitle, required this.settingicon, required this.ontap});

  final String title;
  final String subtitle;
  final IconData settingicon;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [   
            Divider(thickness: 0.8,color: Colors.grey.shade300,),

           Column(
            children: [
              ListTile(
                onTap: ontap,
                leading: CircleAvatar(backgroundColor: Colors.white,child: Center(child: Icon(settingicon,color: Colors.black,),),),
                title: Text(title,style: GoogleFonts.poppins(color: Colors.black),),
                subtitle: Text(subtitle,style: GoogleFonts.poppins(color: Colors.grey),),
              )
            ],
           ),
      ],
    );
  }
}