import 'package:flutter/material.dart';
import 'package:temp_application1/widgets/image_container.dart';

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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  _showSnackBar(BuildContext context, String txt) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(txt)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First App'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade500,
        actions: [Icon(Icons.home), SizedBox(width: 10), Icon(Icons.people)],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: InkWell(
          splashColor: Colors.purple,
          child: Text('Welcome', style: TextStyle(color: Colors.red)),
        ),
      ),
      drawer: Drawer(child: SafeArea(child: Text('App Menu'))),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_showSnackBar(context, 'Tapped on Floating Button')},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.back_hand), label: 'back'),
        ],
      ),
    );
  }
}
