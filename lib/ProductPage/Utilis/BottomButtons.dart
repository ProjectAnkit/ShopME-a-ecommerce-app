import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Utils/ToastMessages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class BottomButtons extends StatefulWidget {
  const BottomButtons({super.key, required this.productid, required this.price});
  final String productid;
  final String price;

  @override
  State<BottomButtons> createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {

  bool buybuttonpressed = false;
  bool cartbuttonpressed = false;
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser;
    return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                           setState(() {
                             cartbuttonpressed = true;    
                           });
                            toastmessage().showsuccess("added to cart successfully");
                             firestore.collection("User").doc(user!.phoneNumber).collection("Cart").doc(widget.productid.toString()).set({
                              "id": widget.productid.toString(),
                              "price": widget.price.toString(),
                             });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        height: 60.h,
                        width: MediaQuery.of(context).size.width*.4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(55.r),
                          boxShadow: [
                            buybuttonpressed
                                ? const BoxShadow()
                                : const BoxShadow(
                                    offset: Offset(1.5, 1.5),
                                    color: Colors.white30,
                                    spreadRadius: 2,
                                    blurRadius: 1,
                                  ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Add to Cart",
                            style: GoogleFonts.poppins(color: Colors.black),
                          ),
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: (){
                          
                          setState(() {
                          buybuttonpressed = true;
                        });

                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        height: 60.h,
                        width: MediaQuery.of(context).size.width*.4,
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(55.r),
                        boxShadow: [
                            cartbuttonpressed
                                ? const BoxShadow()
                                :  const BoxShadow(
                                    offset: Offset(1.5, 1.5),
                                    color: Colors.white30,
                                    spreadRadius: 2,
                                    blurRadius: 1,
                                  ),
                          ],),
                        child: Center(
                          child: Text("Buy now",style: GoogleFonts.poppins(color: Colors.black),),
                        ),
                      ),
                    ),
                  ],
                );
  }
}