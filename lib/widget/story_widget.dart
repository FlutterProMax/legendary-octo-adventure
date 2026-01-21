import 'package:flutter/material.dart';

class StoryWidget extends StatefulWidget {
  final String image;
  const StoryWidget({super.key, required this.image});

  @override
  State<StoryWidget> createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              widget.image,
              width: 400,
              height: 650,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 50,
            right: 20,
            child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: Colors.white,
                size: 30,
              )
            )
          )
        ],
      ),
    );
  }
}
