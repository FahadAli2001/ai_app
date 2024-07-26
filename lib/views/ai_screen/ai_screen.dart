import 'package:ai_app/views/detail_page_screen/detail_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
 
 

     List<String> itemsList = [
    "Text Scanner",
    "Barcode Scanner",
    "Label Scanner",
    "Face Detection",
    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: -10, end: -12),
              showBadge: true,
              ignorePointer: false,
              onTap: () {},
              badgeContent:
                  const Icon(Icons.check, color: Colors.white, size: 10),
              badgeAnimation: const badges.BadgeAnimation.rotation(
                animationDuration: Duration(seconds: 1),
                colorChangeAnimationDuration: Duration(seconds: 1),
                loopAnimation: false,
                curve: Curves.fastOutSlowIn,
                colorChangeAnimationCurve: Curves.easeInCubic,
              ),
              badgeStyle: badges.BadgeStyle(
                shape: badges.BadgeShape.circle,
                badgeColor: Colors.blue,
                padding: const EdgeInsets.all(5),
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.white, width: 2),
                // borderGradient: const badges.BadgeGradient.linear(
                //     colors: [Colors.red, Colors.black]),
                // badgeGradient: const badges.BadgeGradient.linear(
                //   colors: [Colors.blue, Colors.yellow],
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                // ),
                elevation: 0,
              ),
              child:const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: itemsList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>const DetailScreen(),
                    settings: RouteSettings(arguments: itemsList[index]),
                  ),
                );
              },
              child: Tooltip(
                triggerMode: TooltipTriggerMode.longPress,
                message: "tap",
                child: Card(
                  elevation: 15,
                  child: ListTile(
                    title: Text(itemsList[index]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  }
  