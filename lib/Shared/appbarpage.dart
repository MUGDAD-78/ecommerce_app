// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/Pages/checkout.dart';
import 'package:ecommerce_app/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppbarPage extends StatelessWidget {
  const AppbarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
            children: [
              Consumer<Cart>(builder: ((context, classInstancee, child) {
                return Stack(
                  children: [
                    Positioned(
                      top: 1,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(211, 164, 255, 193),
                            shape: BoxShape.circle),
                        child: Text(
                          "${classInstancee.productscart.length}",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 12),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                           Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Checkout(),
                    ),
                  );
                        }, icon: Icon(Icons.add_shopping_cart)),
                  ],
                );
              })),
              SizedBox(
                width: 9.0,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child:
                    Consumer<Cart>(builder: ((context, classInstancee, child) {
                  return Text(
                    "\$ ${classInstancee.prices}",
                    style: TextStyle(fontSize: 18),
                  );
                })),
              ),
            ],
          );
  }
}