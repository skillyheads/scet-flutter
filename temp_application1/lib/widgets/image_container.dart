import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  final String imageUrl;
  final double borderWidth;
  final double width;
  final double height;
  const AppImage({
    required this.imageUrl,
    this.borderWidth = 2,
    this.width = 200,
    this.height = 200,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(5),
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: borderWidth),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1),
        child: Image.asset(imageUrl),
      ),
    );
  }
}
