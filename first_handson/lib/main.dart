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
      initialRoute: "/",
      routes: {
        "/": (context) => MyHomePage(),
        "/image-detail": (context) => ImageDetail(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> urls = [
      "assets/images/image10.jpg",
      "assets/images/image11.jpg",
      "assets/images/image13.jpg",
      "assets/images/image14.jpg",
      "assets/images/image15.jpg",
    ];
    return Scaffold(
      appBar: AppBar(title: Text('Image Viwer')),

      body: ListView.builder(
        itemCount: urls.length,
        itemBuilder: (context, idx) {
          return SimpleImage(url: urls[idx]);
        },
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
        // showBottomSheet(
        //   context: context,
        //   builder: (context) {
        //     return Container(child: Image.asset(url));
        //   },
        // );
        Navigator.pushNamed(context, '/image-detail', arguments: url);
      },
      child: Container(
        height: 150,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Image.asset(fit: BoxFit.fitWidth, url),
      ),
    );
  }
}

class ImageDetail extends StatelessWidget {
  const ImageDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: Text('Image Details')),
      body: Center(child: SimpleImage(url: imageUrl)),
    );
  }
}
