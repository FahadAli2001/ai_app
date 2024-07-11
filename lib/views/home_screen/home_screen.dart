import 'package:ai_app/views/detail_page_screen/detail_page_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> itemsList = [
    "Text Scanner",
    "Barcode Scanner",
    "Label Scanner",
    "Face Detection"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: itemsList.length,
        itemBuilder:(context, index) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: GestureDetector(
            onTap: () {
             Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(),
                      settings: RouteSettings(arguments: itemsList[index]),
                    ),
                  );
            },
            child: Card(
              elevation: 15,
              child: ListTile(
                title: Text(itemsList[index]),
              ),
            ),
          ),
        );
      },),
    );
  }
}