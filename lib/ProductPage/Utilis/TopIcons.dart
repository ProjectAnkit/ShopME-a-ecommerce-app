import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TopIcons extends StatefulWidget {
  const TopIcons({super.key, required this.productid});
  final String productid;

  @override
  State<TopIcons> createState() => _TopIconsState();
}

class _TopIconsState extends State<TopIcons> {

  bool likeontap = false;
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final user = auth.currentUser;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black)),
        IconButton(
            onPressed: () {
              setState(() {
                likeontap = !likeontap;

                if(likeontap)
                {
                  firestore.collection("User").doc(user!.phoneNumber).collection("wishlist").doc(widget.productid).set({
                    "id": widget.productid
                  });
                }

                else{
                 firestore.collection("User").doc(user!.phoneNumber).collection("wishlist").doc(widget.productid).delete();
                }
                });
            },
            icon: likeontap
                ? const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.favorite_border,
                  ))
      ],
    );
  }
}