import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration,
              hintText: "Enter your password",
              enabledBorder: OutlineInputBorder(
                  borderSide: Divider.createBorderSide(context)),
              focusedBorder: OutlineInputBorder(borderSide(color: Colors.grey)),
              fielled: true,
              contentPadding: const EdgeInsets.all(8),
            )
          ],
        ),
      ),
    );
  }
}
