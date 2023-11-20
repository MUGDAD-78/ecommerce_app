// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/Pages/home.dart';
import 'package:ecommerce_app/Pages/login.dart';
import 'package:ecommerce_app/Pages/profilePgae.dart';
import 'package:ecommerce_app/Pages/register.dart';
import 'package:ecommerce_app/Pages/vertifyemailpage.dart';
import 'package:ecommerce_app/Shared/snacknbar.dart';
import 'package:ecommerce_app/provider/cart.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyA_fpVHqOoyORB49pbTcgcu4FpAvTW_nwI",
            authDomain: "ecommerce-app-bce60.firebaseapp.com",
            projectId: "ecommerce-app-bce60",
            storageBucket: "ecommerce-app-bce60.appspot.com",
            messagingSenderId: "425680674193",
            appId: "1:425680674193:web:b23d14310a0778ccc28e30"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return Cart();
        }),
      ],
      child: MaterialApp(
          title: "myApp",
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              } else if (snapshot.hasError) {
                return showSnackBar(context, "Something went wrong");
              } else if (snapshot.hasData) {
                return VerifyEmailPage(); //VerifyEmailPage();  home() OR verify email
              } else {
                return Login();
              }
            },
          )),
    );
  }
}
