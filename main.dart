import 'package:flutter/material.dart';
import 'homepage.dart';
// import 'package:loginuicolors/login.dart';
// import 'package:loginuicolors/register.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyLogin(),
    routes: {
      'login': (context) => MyLogin(),
    },
  ));
}