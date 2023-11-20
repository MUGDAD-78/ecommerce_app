// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_constructors_in_immutables, non_constant_identifier_names

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Pages/login.dart';
import 'package:ecommerce_app/Shared/constants.dart';
import 'package:ecommerce_app/Shared/snacknbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show basename;
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
   Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final myemailController = TextEditingController();
  final mypasswordController = TextEditingController();
  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final titleController = TextEditingController();
  bool isLoading = true;
  bool showpassowrd = true;
  bool iconvisability = true;

  bool is8passwordcharac = false;
  bool ispassword1num = false;
  bool lowerCase = false;
  bool upperCase = false;
  bool specialCharacter = false;
Uint8List? imgPath;
String? imgName;

  Onpasswordchanged(String password) {
    is8passwordcharac = false;
    ispassword1num = false;
    lowerCase = false;
    upperCase = false;
    specialCharacter = false;
    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        is8passwordcharac = true;
      }

      if (password.contains(RegExp(r'[0-9]'))) {
        ispassword1num = true;
      }

      if (password.contains(RegExp(r'[a-z]'))) {
        lowerCase = true;
      }
      if (password.contains(RegExp(r'[A-Z]'))) {
        upperCase = true;
      }
      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        specialCharacter = true;
      }
    });
  }

  register() async {
    setState(() {
      isLoading = false;
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: myemailController.text,
        password: mypasswordController.text,
      );

// Upload image to firebase storage
     final storageRef = FirebaseStorage.instance.ref("profileIMG/$imgName");
  // use this code if u are using flutter web
  UploadTask uploadTask = storageRef.putData(imgPath!);
  TaskSnapshot snap = await uploadTask;
    String urll = await snap.ref.getDownloadURL();
//-------------------------------------------------------
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      users
          .doc(credential.user!.uid)
          .set({
            'email': myemailController.text,
            'age': ageController.text,
            'title': titleController.text,
            'username': usernameController.text,
            'pass': mypasswordController.text,
            'imgprofile':urll,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "The password provided is too weak.");
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        showSnackBar(context, "The account already exists for that email.");
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    setState(() {
      isLoading = true;
    });
  }

uploadImage2Screen(ImageSource source) async {
 Navigator.pop(context);
 final XFile? pickedImg = await ImagePicker().pickImage(source: source);
  try {
      if (pickedImg != null) {
      imgPath = await pickedImg.readAsBytes();
      setState(() {
      imgName = basename(pickedImg.path);
      int random = Random().nextInt(9999999);
      imgName = "$random$imgName";
      print(imgName);
   });
 } else {
   print("NO img selected");
   }
 } catch (e) {
  print("Error => $e");
   }}

 showmodel() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(22),
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(ImageSource.camera);
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.camera,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Camera",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  uploadImage2Screen(ImageSource.gallery);
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.photo_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Gallery",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
               imgPath ==null ?      CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 210, 190, 190),
                      radius: 64,
                      backgroundImage: AssetImage("assets/Avatar.jpg"),
                    ) : 
                   CircleAvatar(
    radius: 71,
    backgroundImage: MemoryImage(imgPath!),
     ),
                    Positioned(
                        bottom: 1,
                        right: 1,
                        child: IconButton(
                            onPressed: () {
                            showmodel();
                            },
                            icon: Icon(Icons.camera_enhance))),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: usernameController,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    decoration: constdecoration.copyWith(
                        hintText: "Enter your Username ",
                        suffixIcon: Icon(Icons.person)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: ageController,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    decoration: constdecoration.copyWith(
                        hintText: "Enter your age ",
                        suffixIcon: Icon(Icons.numbers_outlined)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: titleController,
                    obscureText: false,
                    keyboardType: TextInputType.text,
                    decoration: constdecoration.copyWith(
                        hintText: "Enter your title ",
                        suffixIcon: Icon(Icons.person_add_alt_1_outlined)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    validator: (value) {
                      // this code means ( if it's true make it null(true) if it's false make red line and write "Enter a valid email").
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
                        suffixIcon: Icon(Icons.email_outlined)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    onChanged: (password) {
                      Onpasswordchanged(password);
                    },
                    validator: (value) {
                      return value!.length < 8
                          ? "Enter at least 8 characters"
                          : null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: mypasswordController,
                    obscureText: showpassowrd ? true : false,
                    keyboardType: TextInputType.text,
                    decoration: constdecoration.copyWith(
                        hintText: "Enter your Password ",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showpassowrd = !showpassowrd;
                              });
                            },
                            icon: showpassowrd
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off))),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      ),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              is8passwordcharac ? Colors.green : Colors.white,
                          border: Border.all(
                              color: Color.fromARGB(255, 206, 202, 202))),
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text("At least 8 characters"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      ),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ispassword1num ? Colors.green : Colors.white,
                          border: Border.all(
                              color: Color.fromARGB(255, 206, 202, 202))),
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text("At least 1 number"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      ),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: upperCase ? Colors.green : Colors.white,
                          border: Border.all(
                              color: Color.fromARGB(255, 206, 202, 202))),
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text("Has Uppercase"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      ),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: lowerCase ? Colors.green : Colors.white,
                          border: Border.all(
                              color: Color.fromARGB(255, 206, 202, 202))),
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text("Has Lowercase"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 15,
                      ),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: specialCharacter ? Colors.green : Colors.white,
                          border: Border.all(
                              color: Color.fromARGB(255, 206, 202, 202))),
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text("Has Special Characters"),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if ((_formKey.currentState!.validate())) {
                      await register();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: ((context) => Login())));
                    } else {
                      showSnackBar(context, "ERROR");
                    }
                  },
                  child: isLoading
                      ? Text(
                          " REGISTER ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      : CircularProgressIndicator(
                          color: Colors.white,
                        ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green),
                      padding: MaterialStatePropertyAll(EdgeInsets.all(20))),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Login())));
                        },
                        child: Text(
                          " SIGN IN ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
