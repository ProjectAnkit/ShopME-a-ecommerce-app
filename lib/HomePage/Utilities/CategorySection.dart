import 'package:ecommerce_app/AllProducts/AllProducts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             ItemContainer(Optionlogo: "assets/Categories/Shirt.png",product: "Upperwear"),
             ItemContainer(Optionlogo: "assets/Categories/Pants.png",product: "Lowerwear"),
             ItemContainer(Optionlogo: "assets/Categories/Shoes.png",product: "Footwear"),
            ],
          ),
        ),
         Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             ItemContainer(Optionlogo: "assets/Categories/Utensil.png",product: "Utensils",),
             ItemContainer(Optionlogo: "assets/Categories/Fridge.png",product: "Appliances"),
             ItemContainer(Optionlogo: "assets/Categories/Ring.png",product: "Jewellery",),
            ],
          ),
        ),
         Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             ItemContainer(Optionlogo: "assets/Categories/Laptop.png",product: "Electronics",),
             ItemContainer(Optionlogo: "assets/Categories/Trolleybag.png",product: "Travel"),
             ItemContainer(Optionlogo: "assets/Categories/Phone.png",product: "Mobile",),
            ],
          ),
        ),

       
      ],
    );
  }
}





class ItemContainer extends StatefulWidget {
  const ItemContainer({super.key, required this.Optionlogo, required this.product});
  final String Optionlogo;
  final String product;

  @override
  State<ItemContainer> createState() => _ItemContainerState();
}

class _ItemContainerState extends State<ItemContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> AllProducts(Product: widget.product.toString(),productimage: widget.Optionlogo,)));
    },
    child: Column(
      children: [
        Container(
              height: 90.h,
              width: 90.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.r),
                  color: Colors.black),
              child: Center(
                child: Image(
                  image: AssetImage(widget.Optionlogo),
                  height: 70.h,
                  width: 70.w,
                ),
              )),

        SizedBox(
          height: 3.h,
        ),


        Text(widget.product,style: GoogleFonts.poppins(color: Colors.black),)
      ],
    ),
  );
  }
}


        // Stack(
        //     alignment: Alignment.center,
        //     children: [
        //       Center(child: Text("UPPERWEAR",style: GoogleFonts.jost(fontSize: 66,color: Colors.grey.shade400),)),
        //       Center(
        //         child: Hero(
        //           tag: widget.Product, 
        //         child: Image(image: AssetImage(widget.productimage))),
        //       ),
        //     ],
        //   ),

