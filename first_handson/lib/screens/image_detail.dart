import 'package:flutter/material.dart';

class ImageDetails extends StatelessWidget {
  const ImageDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: Text('Image Details')),
      body: Container(
        margin: EdgeInsets.all(25),
        decoration: BoxDecoration(border: Border.all(width: 3)),
        child: Image.asset(imageUrl),
      ),
    );
  }
}
