import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Utils/ToastMessages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowModalBottomsheet{
  final namecontroller = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

 Future<dynamic> showsheet(BuildContext context)async{
  final user = auth.currentUser;
  DocumentSnapshot doc = await firestore.collection("User").doc(user!.phoneNumber).get();

  if(!doc.exists){
      // ignore: use_build_context_synchronously
      await showModalBottomSheet(
    enableDrag: false,
    context: context, 
    builder: (context){
      return SizedBox(
        height: 220,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Text("Please enter your name ,to continue shopping",style: GoogleFonts.poppins(fontSize: 18),),
              Padding(
                padding: const EdgeInsets.only(top: 20.0,bottom: 20),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.grey)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: TextFormField(
                        controller: namecontroller,
                        keyboardType: TextInputType.name,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Full name",
                          hintStyle: GoogleFonts.poppins(),                         
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: ()async{

                      Navigator.pop(context);
                       
                       try{
                          await firestore.collection("User").doc(user.phoneNumber).set({
                            "name": namecontroller.text.toString(),
                            "phoneNumber": user.phoneNumber,
                            "email" : "",
                            "isSeller": false
                          });
                       }
                       catch(e){
                          log(e.toString());
                          toastmessage().showerror(e.toString());
                       }
                  },
                  child: Text("Continue >>>",style: GoogleFonts.poppins(color: Colors.deepPurple,fontSize: 14),)))
            ],
          ),
        )
      );
     }
    );
  }

  else{
    return Container();
  }
  
 }
}