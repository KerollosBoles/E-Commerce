import 'package:e_commerce/pages/home.dart';
import 'package:e_commerce/pages/login.dart';
import 'package:e_commerce/pages/register.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
