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
              Text("\$ 13",style: TextStyle(fontSize: 18),
),
),
        
            ],
          ),
        ],
        title: Text("Home"),
      ),
    );
  }
}