import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/CartPage/CartPage.dart';
import 'package:ecommerce_app/HomePage/HomeScreen.dart';
import 'package:ecommerce_app/HomePage/Utilities/DrawerSection.dart';
import 'package:ecommerce_app/HomePage/Utilities/ReportPage.dart';
import 'package:ecommerce_app/HomePage/Utilities/ShowBottomsheet.dart';
import 'package:ecommerce_app/ProfilePage/Profilepage.dart';
import 'package:ecommerce_app/Seller/SellerPage.dart';
import 'package:ecommerce_app/Wishlist/WishlistPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ShowModalBottomsheet().showsheet(context);
    });
  }

  bool isHomePage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        child: DrawerSection(
          isHomePage: isHomePage,
          isHomePagechanged: (p0) {
            setState(() {
              isHomePage = p0;
            });
          },),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Container(
                    width: MediaQuery.of(context).size.width*0.7,
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400,),borderRadius: BorderRadius.circular(45.r),color: Colors.grey.shade100),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 16.0.w),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search product",
                            hintStyle: GoogleFonts.poppins()
                          ),
                        ),
                      ),
                  ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){

          }, icon: Icon(Icons.search))
        ],
      ),

      body: SafeArea(
        child: Stack(
          children: [

            isHomePage ? const HomeScreen() : const SellerPage(),

            isHomePage? Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60.h,
                decoration:  BoxDecoration(color: Colors.white,boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, -0.5),
                    color: Colors.grey.shade300,
                    spreadRadius: 1
                  )
                ]),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 1.0.h, horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                       
                         InkWell(
                          onTap: () async {

                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ReportPage()));
                           
                          },
                          child: Container(
                            height: 36.h,
                            width: 36.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade400),
                                color: Colors.white),
                            child: const Center(
                              child: Icon(
                                Icons.support_agent_outlined,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),


              

                        InkWell(
                          onTap: () async {

                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const CartPage()));
                           
                          },
                          child: Container(
                            height: 36.h,
                            width: 36.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade400),
                                color: Colors.white),
                            child: const Center(
                              child: Icon(
                                Icons.shopping_cart,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),


                        InkWell(
                          onTap: () async {

                             Navigator.push(context, MaterialPageRoute(builder: (context)=> const WishlistPage()));
                           
                          },
                          child: Container(
                            height: 36.h,
                            width: 36.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade400),
                                color: Colors.white),
                            child: const Center(
                              child: Icon(
                                Icons.favorite,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),


                         InkWell(
                          onTap: () async {
                            final user = auth.currentUser;
                            final userdata = await firestore
                                .collection("User")
                                .doc(user!.phoneNumber)
                                .get();
                            Map<String, dynamic> usermap =
                                userdata.data() as Map<String, dynamic>;
                            String name = usermap["name"].toString();
                            String phoneNumber =
                                usermap["phoneNumber"].toString();
                            String email = usermap["email"].toString();

                            // ignore: use_build_context_synchronously
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePage(
                                          name: name,
                                          phoneNumber: phoneNumber,
                                          email: email,
                                        )));
                          },
                          child: Container(
                            height: 36.h,
                            width: 36.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade400),
                                color: Colors.white),
                            child: const Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ):Container(),
          ],
        ),
      ),
    );
  }
}
