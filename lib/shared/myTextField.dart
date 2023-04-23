import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

final String hinttexttt;
final TextInputType TextInputTypeee;
final bool isPassword;


MyTextField({Key? key,

  required this.TextInputTypeee,
  required this.isPassword,
  required this.hinttexttt,
}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextField(
                keyboardType: TextInputTypeee,
                obscureText: isPassword,
                decoration: InputDecoration,
                hintText: hinttexttt,
                enabledBorder: OutlineInputBorder(
                    borderSide: Divider.createBorderSide(context)),
                    focusedBorder: OutlineInputBorder
                    (borderSide(color: Color.fromARGB(255, 190, 176, 176)),
                fielled: true,
                contentPadding: const EdgeInsets.all(8),
              );
  }
}