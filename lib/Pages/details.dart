// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, must_be_immutable, use_key_in_widget_constructors

import 'package:ecommerce_app/Shared/allproducts.dart';
import 'package:ecommerce_app/Shared/appbarpage.dart';
import 'package:ecommerce_app/Shared/colors.dart';
import 'package:flutter/material.dart';


class Detailst extends StatefulWidget {

  Product transproduct;
  Detailst({
    required this.transproduct
  });
  @override
  State<Detailst> createState() => _DetailstState();
}

class _DetailstState extends State<Detailst> {
  // const Detailst({super.key});
bool isShow = true; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        backgroundColor: appbargreen,
        actions: [
      AppbarPage(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              widget.transproduct.picture,
              width: double.infinity,
              height: 400,
            ),
            SizedBox(
              height: 11,
            ),
            Text(
              "\$ ${widget.transproduct.price}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(4.0),
                  child: Text("New", style: TextStyle(color: Colors.black)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Color.fromARGB(133, 231, 34, 34),
                  ),
                ),
                /*Row for Stars*/ Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: const Color.fromARGB(255, 235, 212, 10),
                      size: 23,
                    ),
                    Icon(
                      Icons.star,
                      color: const Color.fromARGB(255, 235, 212, 10),
                      size: 23,
                    ),
                    Icon(
                      Icons.star,
                      color: const Color.fromARGB(255, 235, 212, 10),
                      size: 23,
                    ),
                    Icon(
                      Icons.star,
                      color: const Color.fromARGB(255, 235, 212, 10),
                      size: 23,
                    ),
                    Icon(
                      Icons.star,
                      color: const Color.fromARGB(255, 235, 212, 10),
                      size: 23,
                    ),
                  ],
                ),
                SizedBox(width: 77),
                Row(
                  children: [
                    Icon(
                      Icons.edit_location,
                      color: Color.fromARGB(168, 3, 65, 27),
                    ),
                    Text(
                      "Flower Shop",
                    )
                  ],
                ),
              ],
            ), // Big Row
      
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Details : ",
                style: TextStyle(
                  fontSize: 22,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(height: 16,),
            Text("A flower, sometimes known as a bloom or blossom, is the reproductive structure found in flowering plants (plants of the division Angiospermae). Flowers produce gametophytes, which in flowering plants consist of a few haploid cells which produce " , 
    style: TextStyle(fontSize: 20 ,), maxLines: isShow? 2 : null ,
          overflow: TextOverflow.fade ,
            ),
            TextButton(onPressed: (){
            setState(() {
             isShow = !isShow;
            });
            }, child: Text(isShow? "Show more " : "Show less ", style: TextStyle(fontSize: 22),)),
         ],
        ),
      ),
    );
  }
}
