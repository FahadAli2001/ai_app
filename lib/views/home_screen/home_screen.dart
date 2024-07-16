import 'package:ai_app/views/ai_screen/ai_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dragable_screen/dragble_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Center(
               child: CupertinoButton(
                color: Colors.amber,
                child: Text("AI"), onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const AiScreen()));
               }),
             ),
              Center(
                child: CupertinoButton(
                  color: Colors.amberAccent,
                  child: Text("Dragable"), onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const DragableScreen()));
                             }),
              )
          ],),
        )
    );
  }
}
