// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_build_context_synchronously

import 'package:ecommerce_app/Pages/checkout.dart';
import 'package:ecommerce_app/Pages/details.dart';
import 'package:ecommerce_app/Pages/profilePgae.dart';
import 'package:ecommerce_app/Shared/allproducts.dart';
import 'package:ecommerce_app/Shared/appbarpage.dart';
import 'package:ecommerce_app/Shared/colors.dart';
import 'package:ecommerce_app/Shared/snacknbar.dart';
import 'package:ecommerce_app/provider/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Mugdad Elneama",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  )),
              accountEmail: Text("megdad.2003@gmail.com"),
              currentAccountPicture: CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage("assets/profile.jpg")),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/coding.jpg"), fit: BoxFit.cover),
              ),
            ),
            ListTile(
                title: Text("Home"),
                leading: Icon(Icons.home),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                  );
                }),
            ListTile(
                title: Text("My products"),
                leading: Icon(Icons.add_shopping_cart),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Checkout(),
                    ),
                  );
                }),
            ListTile(
                title: Text("About"),
                leading: Icon(Icons.help_center),
                onTap: () {}),
            ListTile(
                title: Text("Profile Page"),
                leading: Icon(Icons.person),
                onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                }),
            ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.exit_to_app),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  showSnackBar(context, "You Logued out");
                }),
            Container(
              margin: EdgeInsets.only(bottom: 25),
              child: Text("Developed by Mugdad Elneama © 2023",
                  style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: appbargreen,
        actions: [
          AppbarPage(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 /*width*/ / 2 /*hight*/,
                crossAxisSpacing: 10,
                mainAxisSpacing: 33),
            itemCount: allProudcts.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Detailst(
                        transproduct: allProudcts[index],
                      ),
                    ),
                  );
                },
                child: GridTile(
                    footer: GridTileBar(
                      subtitle: Text(
                        "\$ ${allProudcts[index].price}",
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing:
                          Consumer<Cart>(builder: ((context, carttt, child) {
                        return IconButton(
                            color: Color.fromARGB(255, 62, 94, 70),
                            onPressed: () {
                              carttt.add(allProudcts[index]);
                            },
                            icon: Icon(Icons.add));
                      })),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -3,
                          bottom: -9,
                          right: 0,
                          left: 0,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: Image.asset(allProudcts[index].picture)),
                        ),
                      ],
                    )),
              );
            }),
      ),
    );
  }
}
