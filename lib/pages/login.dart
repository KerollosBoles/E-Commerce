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
              const SizedBox(height: 64,
              ),
              MyTextField(
              TextInputTypeee: TextInputTypeee.emailAddress,
              isPassword: false,
              hinttexttt: "Enter your Email Address or Username",
              ),
              const  SizedBox(height: 33),
              MyTextField(
              TextInputTypeee: TextInputTypeee.Password,
              isPassword: true,,
              hinttexttt: "Enter your password",
              ),

              const  SizedBox(height: 33),

               ElevatedButton(
                onPressed: (){}, 
               child: Text("click here", style: TextStyle(fontSize: 19),),
               style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange),
                padding: MaterialStateProperty.all(EdgeInsets.all(zero)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius),
               ),
               )

            ],
          ),
        ),
      ),
    );
  }
}
