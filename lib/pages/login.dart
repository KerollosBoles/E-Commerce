import 'package:e_commerce/shared/myTextField.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/pages/shared/myTextField.dart';
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
              MyTextField(),
                     
            ],
          ),
        ),
      ),
    );
  }
}
