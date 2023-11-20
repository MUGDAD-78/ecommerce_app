// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce_app/Shared/appbarpage.dart';
import 'package:ecommerce_app/Shared/colors.dart';
import 'package:ecommerce_app/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  Widget build(BuildContext context) {
    final classInstancee = Provider.of<Cart>(context);
    return Scaffold(
     appBar: AppBar(
      title: Text("Checkout Screen"),
      backgroundColor: appbargreen,
   actions: [
    AppbarPage(),
   ],
     ),
     body: Column(
       children: [
         SingleChildScrollView(
           child: SizedBox(
             height: 300,
             child: ListView.builder(
            itemCount: classInstancee.productscart.length,
            itemBuilder: (BuildContext context, index,) {
            return Card(
              child: ListTile(
              subtitle: Text("${classInstancee.productscart[index].location} - \$${classInstancee.productscart[index].price}"),
              leading: CircleAvatar(backgroundImage:AssetImage("${classInstancee.productscart[index].picture}"),),
              title: Text(classInstancee.productscart[index].name),
              trailing: IconButton(
              onPressed: () { 
                classInstancee.delete(classInstancee.productscart[index]);
              },
              icon: Icon(Icons.remove)),
           ),
            );
             }),
           ),
         ),
         SizedBox(height: 100,),
ElevatedButton(
   onPressed: (){},
   style: ButtonStyle(
     backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 245, 28, 133)),
     padding: MaterialStateProperty.all(EdgeInsets.all(20)),
     shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
  ),
   child: Text(" PAY \$${classInstancee.prices}", style: TextStyle(fontSize: 19),),
),
       ],
     ),
    );
  }
}