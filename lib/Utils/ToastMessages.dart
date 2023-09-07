import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class toastmessage{

  void showerror(e){
    Fluttertoast.showToast(
      msg: e.toString(),
      backgroundColor: Color.fromARGB(227, 239, 63, 63),
      textColor: Color.fromARGB(255, 0, 0, 0),
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT
      );
  }

  void showsuccess(s){
    Fluttertoast.showToast(
      msg: s.toString(),
      backgroundColor: Color.fromARGB(225, 7, 216, 167),
      textColor: Color.fromARGB(255, 2, 0, 0),
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT
      );
  }

}