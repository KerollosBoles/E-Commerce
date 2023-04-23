import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                decoration: InputDecoration,
                hintText: "Email Address or User Name",
                enabledBorder: OutlineInputBorder(
                    borderSide: Divider.createBorderSide(context)),
                    focusedBorder: OutlineInputBorder
                    (borderSide(color: Color.fromARGB(255, 190, 176, 176)),
                fielled: true,
                contentPadding: const EdgeInsets.all(8),
              );
  }
}