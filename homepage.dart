import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('C:\\Users\\Satyam\\Desktop\\satyam\\ipd\\image\\1.png'), fit: BoxFit.cover),
      ),
    );
  }
}
//'C:\\Users\\Satyam\\Desktop\\satyam\\ipd\\test\\image\\1.png'