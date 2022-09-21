import 'package:flutter/material.dart';
import 'package:projeto_firebase/login.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: Login(),
    debugShowCheckedModeBanner: false,
  ));
}