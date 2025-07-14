import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(title: 'Flutter Grid Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  String title;
  MyHomePage({required this.title, super.key});
  List<String> images = [
    'assets/images/image4.jpg',
    'assets/images/image5.jpg',
    'assets/images/image6.jpg',
    'assets/images/image7.jpg',
    'assets/images/image8.jpg',
    'assets/images/image9.jpg',
    'assets/images/image10.jpg',
    'assets/images/image11.jpg',
    'assets/images/image12.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate columns based on screen width
    int columns = 2; // default for mobile
    if (screenWidth > 600) columns = 3; // tablet
    if (screenWidth > 900) columns = 4; // desktop
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: GridView.builder(
        itemCount: images.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Image.asset(images[index], fit: BoxFit.fitHeight),
          );
        },
      ),
    );
  }
}
