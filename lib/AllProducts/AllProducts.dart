import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/AllProducts/LoadedProducts.dart';
import 'package:ecommerce_app/AllProducts/LoadingProducts.dart';
import 'package:ecommerce_app/AllProducts/UpperButtons.dart';
import 'package:ecommerce_app/Seller/Utilis/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({super.key, required this.Product, required this.productimage});
  final String Product;
  final String productimage;

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {

  bool isLoading = true;

  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
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

          }, icon: const Icon(Icons.search))
        ],
      ),
      body: Column(
        children: [
                  
          SizedBox(
            height: 15.h,
          ),


          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  InkWell(
                    onTap: (){

                    },
                    child: const UpperButton(name: "Assured", buticon: Icons.assignment_turned_in)),
                  InkWell(
                    onTap: (){

                    },
                    child: const UpperButton(name: "Filter", buticon: Icons.filter_alt_outlined)),
              ],
            ),
          ),

          SizedBox(
            height: 20.h,
          ),


          Expanded(
            child: StreamBuilder(
              stream: firestore.collection("Product").where("Option",isEqualTo: widget.Product.toString()).snapshots(),
              builder: (context,snapshot){
                
                if(snapshot.connectionState == ConnectionState.waiting)
                {
                  return GridView.builder(    
              scrollDirection: Axis.vertical,
              itemCount: 6,    
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 320), 
              itemBuilder: (context,index){

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 6.h),
                    child:  const LoadingProducts(),
                  );
                 });
                }

                else{
                  QuerySnapshot productsnapshot = snapshot.data as QuerySnapshot;
                
                  if(snapshot.hasData)
                  {    
                    
                    return GridView.builder(    
              scrollDirection: Axis.vertical,
              itemCount: productsnapshot.docs.length,    
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 320), 
              itemBuilder: (context,index){
        
                 Map<String,dynamic> productdata = productsnapshot.docs[index].data() as Map<String,dynamic>;
                 ProductModel productmodel = ProductModel().fromMap(productdata);

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 6.h),
                    child: LoadedProducts(productmodel: productmodel),
                  );
                 });

                  }

                  else{
                    return Container();
                  }
                }
              }),
          ),
        ],
      ),
    );
  }
}