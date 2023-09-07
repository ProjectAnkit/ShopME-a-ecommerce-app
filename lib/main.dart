import 'package:ecommerce_app/Loading/LoadingPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main()async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await dotenv.load(fileName: "assets/.env");

  runApp(
    ScreenUtilInit(
      builder: (context, child) {
        return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoadingPage(),
       );
      },
      designSize: const Size(411.42, 843.42),
    )
  );
}

//command to get SHA fingerprints "keytool -list -v -keystore "C:\Users\Username\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android"