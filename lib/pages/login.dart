import 'package:e_commerce/shared/const_text_field.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/pages/shared/const_text_field.dart';
class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(33.3)
          child: Column(
            children: [
              const SizedBpx(height: 64,
              ),
              MyTextField(),
              SizedBox(height: 33),
              
                      
            ],
          ),
        ),
      ),
    );
  }
}
