// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_build_context_synchronously, deprecated_member_use, unused_local_variable



import 'package:ecommerce_app/Pages/forgotPage.dart';
import 'package:ecommerce_app/Pages/register.dart';
import 'package:ecommerce_app/Shared/colors.dart';
import 'package:ecommerce_app/Shared/constants.dart';
import 'package:ecommerce_app/Shared/snacknbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
   Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
 bool showpassowrd = true;
 final myemailController = TextEditingController();
  final mypasswordController = TextEditingController();

signin() async { 
   showDialog(context: context, builder: (context) {return Center(child: CircularProgressIndicator(color: Colors.white,));});
  try {
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: myemailController.text,
    password: mypasswordController.text,
  );
} on FirebaseAuthException catch (e) {
if (e.code == 'user-not-found') {
  showSnackBar(context, "No user found for that email.");
  } else if (e.code == 'wrong-password') {
    // print('Wrong password provided for that user.');
   showSnackBar(context, "Wrong password provided for that user.");
  }
  else { 
    showSnackBar(context, "Error");
  }
    // showSnackBar(context, "EROOR : ${e.code}");
}
Navigator.pop(context);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in "),
        backgroundColor: appbargreen,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              controller: myemailController,
              obscureText: false,
                keyboardType: TextInputType.emailAddress,
                decoration: constdecoration.copyWith(hintText: "Enter your Email " ,    
                 suffixIcon: Icon(Icons.email_outlined),
                ),
                

                ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              controller:mypasswordController,
                obscureText:showpassowrd? true : false,
                  keyboardType: TextInputType.text,
                  decoration: constdecoration.copyWith(hintText: "Enter your Password " ,       
                    suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              showpassowrd = !showpassowrd;
                            });
                          },
                          icon: showpassowrd
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off)),
                  ),
                  ),
          ),
          ElevatedButton(
            onPressed: () async {
           await signin();
          //  showSnackBar(context, "YOU SIGNED IN ");
            },
            child: Text(
              " SIGN IN ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.green),
                padding: MaterialStatePropertyAll(EdgeInsets.all(20))),
          ),
           SizedBox(height: 20,),
          TextButton(onPressed: (){
           Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPage(),
                    ),
                  );
          }, child: Text(" Forgot Password ? " , style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: const Color.fromARGB(255, 66, 160, 236)),),),
          SizedBox(height: 15,),  
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Do not have an account?",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              TextButton(
                  onPressed: () {
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => Register())));
                  },
                  child: Text(
                    " SIGN UP ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                  )),
            ],
          ),
SizedBox(height: 10,),
              Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Expanded(
                          child: Divider(
                        color: Colors.black,
                      )),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "OR",
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Divider(
                        color: Colors.black,
                      )),
                      SizedBox(
                        width: 50,
                      ),
                    ],
                  ),
                  SizedBox(height: 18,),
                 GestureDetector(
                  onTap: () {
                  },
                   child: Container(
                          height: 60,
                          width: 70,
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color.fromARGB(255, 239, 83, 80),
                              width: 1,
                            ),
                          ),
                          child: SvgPicture.asset(
                            "assets/google-plus.svg",
                            color: const Color.fromARGB(255, 239, 83, 80),
                            height: 25,
                          ),
                        ),
                 ),
        ],
      ),
    );
  }
}
