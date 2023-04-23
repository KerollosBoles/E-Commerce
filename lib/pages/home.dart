import 'package:flutter/material.dart';

import '../shared/constant_colors.dart';
class Home extends StatelessWidget {
  const Home({Key?key} : super(key:key));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        actions:[
          Row(
            children: [
               Stack(
                children: [
                  Container(
                    child:
                      Text("8",
                      style: TextStyle(color: Color.fromARGB(255,0,0,0)
                      ),
                      ),
                 children: [
                   IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_shopping_cart),
                   ),
                 ],
               ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Text(
                  "\$ 13",
                  style: TextStyle(fontSize: 18),
                  ),
              ),
            ],
          ),
          
        ],
        title: Text("Home"),
      ),
        ],
    );

  }
}