import 'package:flutter/material.dart';

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
              TextField(
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                decoration: InputDecoration,
                hintText: "Email Address or User Name",
                enabledBorder: OutlineInputBorder(
                    borderSide: Divider.createBorderSide(context)),                focusedBorder: OutlineInputBorder(borderSide(color: Colors.grey)),
                fielled: true,
                contentPadding: const EdgeInsets.all(8),
              )
            ],
          ),
        ),
      ),
    );
  }
}
