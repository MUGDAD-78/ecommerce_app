// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_const_constructors_in_immutables, use_build_context_synchronously

import 'package:ecommerce_app/Pages/login.dart';
import 'package:ecommerce_app/Shared/colors.dart';
import 'package:ecommerce_app/Shared/constants.dart';
import 'package:ecommerce_app/Shared/snacknbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPage extends StatefulWidget {
  ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final _formKey = GlobalKey<FormState>();
  final myemailController = TextEditingController();
  bool isLoading = true;
  restPassword() async {
    setState(() {
      isLoading = false;
    });
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: myemailController.text);
      showSnackBar(context, "Done, please check ur email.");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => Login())));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "EROOR : ${e.code}");
    }

    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest Password "),
        backgroundColor: appbargreen,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter your email to rest your password. ",
              style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextFormField(
                validator: (value) {
                  return value!.contains(RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                      ? null
                      : "Enter a valid email ";
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: myemailController,
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                decoration: constdecoration.copyWith(
                  hintText: "Enter your Email ",
                  suffixIcon: Icon(Icons.email_outlined),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if ((_formKey.currentState!.validate())) {
                  restPassword();
                } else {
                  showSnackBar(context, "ERROR");
                }
              },
              child: isLoading
                  ? Text(
                      " Rest Password ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  : CircularProgressIndicator(
                      color: Colors.white,
                    ),
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green),
                  padding: MaterialStatePropertyAll(EdgeInsets.all(20))),
            ),
          ],
        ),
      ),
    );
  }
}
