import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/CartPage/GetProduct.dart';
import 'package:ecommerce_app/CartPage/razorpay_response_model.dart';
import 'package:ecommerce_app/Seller/Utilis/ProductModel.dart';
import 'package:ecommerce_app/Utils/ToastMessages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:retry/retry.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

 
  late Razorpay _razorpay;
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  int totalprice = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }


  void _handlePaymentSuccess(PaymentSuccessResponse response) {
  toastmessage().showsuccess("RAZOR_SUCCESS"+response.paymentId.toString()+"--"+response.orderId.toString());
}

  void _handlePaymentError(PaymentFailureResponse response) {
  toastmessage().showerror("RAZOR_FAIL"+response.code.toString()+"--"+response.message.toString());
}

  void _handleExternalWallet(ExternalWalletResponse response) {
  toastmessage().showsuccess("RAZOR_WALLET"+response.walletName.toString());
}
  
  
  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser;
    return Scaffold(
      body: StreamBuilder(
            stream: firestore
                .collection("User")
                .doc(user!.phoneNumber)
                .collection("Cart")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              } else {
                if (snapshot.hasData) {
                  QuerySnapshot datasnapshot = snapshot.data as QuerySnapshot;
      
                  if (datasnapshot.docs.isNotEmpty) {
                    int totalprice = 0;
      
                    for (var doc in datasnapshot.docs) {
                      totalprice += int.parse(doc["price"].toString());
                    }
      
                    return Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 100.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  height: 40.h,
                                  width: 160.w,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.r),
                                          bottomRight: Radius.circular(20.r))),
                                  child: Center(
                                      child: Text(
                                    "My Cart",
                                    style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w500),
                                  ))),
      
                              // ignore: prefer_const_constructors
                              SizedBox(
                                height: 15.h,
                              ),
      
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 5.h,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        child: const Center(
                                          child: Divider(
                                            thickness: 0.8,
                                          ),
                                        ),
                                      ),
                                      Center(
                                          child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 4.0.h, horizontal: 4.w),
                                        child: Text(
                                          "${datasnapshot.docs.length} Items in your cart",
                                          style: GoogleFonts.poppins(
                                              color: Colors.grey),
                                        ),
                                      )),
                                      SizedBox(
                                        height: 5.h,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        child: const Center(
                                          child: Divider(
                                            thickness: 0.8,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 14.0.w),
                                      child: SizedBox(
                                        height: 240.h,
                                        child: ListView.builder(
                                            itemCount: datasnapshot.docs.length,
                                            itemBuilder: (context, index) {
                                              String productid = datasnapshot
                                                  .docs[index]["id"]
                                                  .toString();
      
                                              return FutureBuilder(
                                                  future: getProduct(productid),
                                                  builder: ((context,
                                                      asyncsnapshot) {
                                                    if (asyncsnapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return Container();
                                                    } else {
                                                      if (asyncsnapshot
                                                          .hasData) {
                                                        ProductModel
                                                            productModel =
                                                            asyncsnapshot.data
                                                                as ProductModel;
                                                        return MyCartItem(
                                                          productModel:
                                                              productModel,
                                                        );
                                                      } else {
                                                        return Container();
                                                      }
                                                    }
                                                  }));
                                            }),
                                      )),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 0.8,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 14..w),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 6.0.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Price",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "$totalprice/-",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 6.0.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Discount",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "0/-",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 6.0.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Sale Price",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "$totalprice/-",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 6.0.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Service tax",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "22/-",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 6.0.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Covenience charges",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "0/-",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.grey.shade300,
                                          thickness: 0.8,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 6.0.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Total Price",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "${totalprice + 22}/-",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            decoration:
                                const BoxDecoration(color: Colors.black),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 14.0.w, vertical: 12.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 60.h,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(55.r)),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 12.0.w, left: 30.w),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                maxRadius: 10.r,
                                                backgroundColor: Colors.black,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.arrow_back,
                                                    size: 12.w,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.h,
                                              ),
                                              Text(
                                                "Go back",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await createOrder(totalprice.toString());
                                    },
                                    child: Container(
                                      height: 60.h,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(55.r)),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 12.0.w, left: 30.w),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Place Order",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black),
                                              ),
                                              SizedBox(
                                                width: 10.h,
                                              ),
                                              CircleAvatar(
                                                maxRadius: 10.r,
                                                backgroundColor: Colors.black,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.check,
                                                    size: 12.w,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
      
                  } 
                  
                  else {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: Text(
                            "No Items yet",
                            style: GoogleFonts.poppins(),
                          )),
                        ],
                      ),
                    );
                  }
                } else {
                  return Container();
                }
              }
            })
    );
  }



  Future<dynamic> createOrder(String amount) async {
    var mapHeader = <String, String>{};
    mapHeader['Authorization'] = "Basic ${dotenv.env['AUTHORIZATION']!}";
    mapHeader['Accept'] = "application/json";
    mapHeader['Content-Type'] = "application/x-www-form-urlencoded";
    var map = <String, String>{};
    setState(() {
      map['amount'] = "${(num.parse(amount) * 100)}";
    });
    map['currency'] = "INR";
    map['receipt'] = "receipt1";
    print("map $map");
    final response = await retry(
      // Make a GET request
      () => http
          .post(Uri.https("api.razorpay.com","/v1/orders"),
          headers: mapHeader,
          body: map)
          .timeout(const Duration(seconds: 2)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    print("....${response.body}");
    if (response.statusCode == 200) {
      RazorpayOrderResponse data =
      RazorpayOrderResponse.fromJson(json.decode(response.body));
      openCheckout(data,amount);
    } else {
      toastmessage().showerror("Something went wrong!");
    }
  }

  



  void openCheckout(RazorpayOrderResponse data,String amount) async {
    var options = {
      'key': dotenv.env['RAZOR_TEST'],
      'amount': "${(num.parse(amount) * 100)}",
      'name': 'ShopMe',
      'description': '',
      'order_id': '${data.id}',
    };
 
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
  
}



class MyCartItem extends StatefulWidget {
  const MyCartItem({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<MyCartItem> createState() => _MyCartItemState();
}

class _MyCartItemState extends State<MyCartItem> {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              firestore
                  .collection("User")
                  .doc(user!.phoneNumber)
                  .collection("Cart")
                  .doc(widget.productModel.id)
                  .delete();
            },
            child: Container(
              height: 30.h,
              width: 40.w,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10.r)),
              child:  Center(
                child: Icon(
                  Icons.delete,
                  color: Colors.grey,
                  size: 20.w,
                ),
              ),
            ),
          ),

           SizedBox(
            height: 3.h,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 190.h,
                width: 140.w,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15.r)),
                    child: CachedNetworkImage(
                                       imageUrl: widget.productModel.image.toString(),
                                       placeholderFadeInDuration: const Duration(milliseconds: 100),
                                       placeholder: (context, url) => 
                                       Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.white60,
                                         child: Container(
                                            height: 220.h,
                                            decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius: BorderRadius.circular(10.r)),
                                          ),
                                       ),
                                      ),
              ),
    
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.productModel.name.toString(),style: GoogleFonts.poppins(color: Colors.black,fontSize: 20.sp),overflow: TextOverflow.ellipsis,softWrap: true,),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0.h),
                    child: Row(
                      children: [
                        Text("Size : ",style: GoogleFonts.poppins(color: Colors.black,fontSize: 18.sp),),
                        Container(
                          decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.circular(5.r)),
                          child: Padding(
                          padding: EdgeInsets.all(4.0.w),
                          child: Center(child: Text("M",style: GoogleFonts.poppins(color: Colors.black,fontSize: 20.sp),)),
                        ),
                        ),
                      ],
                    ),
                  ),
                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Quantity : ",style: GoogleFonts.poppins(color: Colors.grey,fontSize: 14.sp),),
                      Row(
                        children: [
                          
                          IconButton(onPressed: (){

                          }, icon: const Icon(Icons.add)),

                          Container(
                            decoration: BoxDecoration(color: Colors.grey.shade300,borderRadius: BorderRadius.circular(2.r)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.0.w),
                              child: Text("1",style: GoogleFonts.poppins(color: Colors.black),),
                            )),

                          IconButton(onPressed: (){

                          }, icon: const Icon(Icons.remove)),
                        ],
                      ),
                    ],
                  ),

                  Text("${widget.productModel.price}/-",style: GoogleFonts.poppins(color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.w500)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}





