import 'package:flutter/material.dart';

import '../shared/constant_colors.dart';
class Home extends StatelessWidget {
  const Home({Key?key} : super(key:key));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      drawer: Drawer(
        child: Column(
         children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage("assets/image/02.jpeg"), 
              fit: BoxFit.cover),
            ),

            curentAccountPicture: CircleAvatar(
              radius: 55,
             backgroendImage: AssetImage("assets/image/01.jpg"),
             ),
            accountEmail: Text("KerollosBoles@gmail.com"),
            accountName:Text(
              "Kerollos Boles",
              style:TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),,
            ),
            ),
            
            
        
        ListTile(
           title: Text("Home"),
           leading: Icon(Icons.home),
           onTap: () { }
         ),
          
         ListTile(
           title: Text("My products"),
           leading: Icon(Icons.add_shopping_cart),
           onTap: () { }
         ),
        
         ListTile(
           title: Text("About"),
           leading: Icon(Icons.help_center),
           onTap: () { }
         ),
        
         ListTile(
           title: Text("Logout"),
           leading: Icon(Icons.exit_to_app),
           onTap: () { }
        ),    
],
),
      ),  
Container(
   margin: EdgeInsets.only(bottom: 12),
   child: Text("Developed by Kerollos Boles © 2022",
 style: TextStyle(fontSize: 16)),
 )







        appBar: AppBar(
 backgroundColor: Color.fromARGB(255, 76, 141, 95),
 title: Text("Home"),
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
 onPressed: () { },
 icon: Icon(Icons.add_shopping_cart)),
 ],
 ),
 Padding(
 padding: const EdgeInsets.only(right: 12),
 child: Text("\$ 128"),
 )
 ],
 )
 ],
 ),

  }
}