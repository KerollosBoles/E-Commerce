import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../shared/constant_colors.dart';
import 'package:flutter/material.dart';
class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Color.fromARGB(255, 76, 141, 95),
        title: Text("Details Screen"),
        actions: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                      child: Text(
                        "8",
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(211, 164, 255, 193),
                          shape: BoxShape.circle)),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.add_shopping_cart)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Text("\$ 128"),
              )
            ],
          ),
        ],
      ),
     
     
      body: Column(
        children:
        [
          Image.assets("assets/image/images (1).jpeg"),
          SizedBox(height:11),,
          Text("\$ 1234.99", style: TextStyle(fontSize: 20)),
          SizedBox(height:16),
          Row(
            children:[
             Container(
              padding: const EdgeInsets.all(4),
              child:
                Text("New",style: TextStyle(fontSize: 15)),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255,255,129,129),
                  borderRadius: Edge: BorderRadius.circular(4),
                ),
             
             ) 
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Icon(
                  Icons.star,
                  size: 26
                  color: Color.fromARGB(255,255,191,0)
                  ),
                    Icon(
                  Icons.star,
                  size: 26
                  color: Color.fromARGB(255,255,191,0)
                  ),
              
                Icon(
                  Icons.star,
                  size: 26
                  color: Color.fromARGB(255,255,191,0)
                  ),
],
                Icon(
                  Icons.star,
                  size: 26
                  color: Color.fromARGB(255,255,191,0)
                  ),
              
                Icon(
                  Icons.star,
                  size: 26
                  color: Color.fromARGB(255,255,191,0)
                  ),
              ],
              ],
            ),
            ]
          ),
          
          ]
      )
    );
  }
}
