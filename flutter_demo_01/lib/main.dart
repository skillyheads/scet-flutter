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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  _showAlert(BuildContext context, String txt) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(txt)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Poster')),
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text('From Drawer'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAlert(context, 'Floating action bar taped'),
        child: Icon(Icons.touch_app),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () => _showAlert(context, 'Body button Pressed'),
          child: Text('Body Button'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        ],
        onTap: (index) => {_showAlert(context, '$index tapped')},
      ),
    );
  }
}
