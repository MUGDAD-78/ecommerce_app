// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetDataFromFireStore extends StatefulWidget {
  final String documentId;

  GetDataFromFireStore({super.key, required this.documentId});

  @override
  State<GetDataFromFireStore> createState() => _GetDataFromFireStoreState();
}

class _GetDataFromFireStoreState extends State<GetDataFromFireStore> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final credential = FirebaseAuth.instance.currentUser;

  final dilogusernameController = TextEditingController();
  MyDilog(Map data, dynamic mykey) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
          child: Container(
            padding: EdgeInsets.all(22),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                    controller: dilogusernameController,
                    maxLength: 30,
                    decoration: InputDecoration(hintText: "${data[mykey]}")),
                SizedBox(
                  height: 22,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          users
                              .doc(credential!.uid)
                              .update({mykey: dilogusernameController.text});

                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cnacel",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        )),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
    
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }
    
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Email: ${data['email']}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            users
                                .doc(credential!.uid)
                                .update({"email": FieldValue.delete()});
                          },
                          icon: Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {
                            MyDilog(data, 'email');
                          },
                          icon: Icon(Icons.edit)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Username: ${data['username']}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                          setState(() {
                              users
                                .doc(credential!.uid)
                                .update({"username": FieldValue.delete()});
                          });
                          },
                          icon: Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {
                            MyDilog(data, "username");
                          },
                          icon: Icon(Icons.edit)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Age: ${data['age']}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                        IconButton(
                          onPressed: () {
                          setState(() {
                              users
                                .doc(credential!.uid)
                                .update({"age": FieldValue.delete()});
                          });
                          },
                          icon: Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {
                            MyDilog(data, 'age');
                          },
                          icon: Icon(Icons.edit)),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Title: ${data['title']}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                        IconButton(
                          onPressed: () {
                          setState(() {
                              users
                                .doc(credential!.uid)
                                .update({"title": FieldValue.delete()});
                          });
                          },
                          icon: Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {
                            MyDilog(data, 'title');
                          },
                          icon: Icon(Icons.edit)),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Password: ${data['pass']}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                        IconButton(
                          onPressed: () {
                          setState(() {
                              users
                                .doc(credential!.uid)
                                .update({"pass": FieldValue.delete()});
                          });
                          },
                          icon: Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {
                            MyDilog(data, "pass");
                          },
                          icon: Icon(Icons.edit)),
                    ],
                  ),
                ],
              ),
            ],
          );
        }
        return Text("loading");
      },
    );
  }
}
