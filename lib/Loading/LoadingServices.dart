import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/HomePage/HomePage.dart';
import 'package:ecommerce_app/Login/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


final auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

class LoadingServices{
  final user = auth.currentUser;

  void movetoScreen(BuildContext context)async{ 
    if(user!=null)
    {
      Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
     });
    }

    else{
       Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
     });
    }
  }
}