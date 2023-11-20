// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

const constdecoration = InputDecoration(
  // To delete borders under line

  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide.none,
  ),

  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
    ),
  ),

  // fillColor: Colors.red,

  filled: true,

  contentPadding: const EdgeInsets.all(10),
);
