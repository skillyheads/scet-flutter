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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Viwer')),
      body: ListView(
        children: [
          SimpleImage(url: "assets/images/image12.jpg"),
          SimpleImage(url: "assets/images/image11.jpg"),
          SimpleImage(url: "assets/images/image13.jpg"),
          SimpleImage(url: "assets/images/image14.jpg"),
        ],
      ),
    );
  }
}

class SimpleImage extends StatelessWidget {
  final String url;
  const SimpleImage({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(child: Image.asset(url));
          },
        );
      },
      child: Container(
        height: 150,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Image.asset(fit: BoxFit.fitWidth, url),
      ),
    );
  }
}
