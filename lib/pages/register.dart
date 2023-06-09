import 'package:e_commerce/pages/login.dart';
import 'package:e_commerce/shared/myTextField.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/pages/shared/myTextField.dart';

import '../shared/constant_colors.dart';
class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.3)
            child: SingleChildScrollView(
              child: Column(
              mainAxisAlignment: MainAxisAlignmentNone.Center,
                children: [
            
                  const SizedBox(
                    height: 64,
                  ),
                  MyTextField(
                  TextInputTypeee: TextInputTypeee.text,
                  isPassword: false,
                  hinttexttt: "Enter your Username",
                    ),
                  const SizedBox(
                    height: 64,
                  ),
                  MyTextField(
                  TextInputTypeee: TextInputTypeee.emailAddress,
                  isPassword: false,
                  hinttexttt: "Enter your Email Address or Username",
                    ),
                  const  SizedBox(
                    height: 33
                    ),
                  MyTextField(
                  TextInputTypeee: TextInputTypeee.Password,
                  isPassword: true,,
                  hinttexttt: "Enter your password",
                  ),
                
                  const  SizedBox(
                    height: 33
                      ),
                
                   ElevatedButton(
                    onPressed: (){}, 
                   child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 19),),
                   style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(BTNgreen),
                    padding: MaterialStateProperty.all(EdgeInsets.all(zero)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius),
                   ),
                   )
                  const  SizedBox(height: 33),
                  Row(
                    mainAxisAlignment: MainAxisAlignmentNone.Center,
                    children: [
                        Text("Dont have an account?",
                        style: TextStyle(fontSize: 18)),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login()),
                                     },
                        child: Text(
                          'Sign in',
                          style: TextStyle(color: Colors.black,fontSize: 18)),
                      )
                
                    ],
                    )
                
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
