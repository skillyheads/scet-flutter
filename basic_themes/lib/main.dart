import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manual Theme Demo',
      theme: blueTheme,
      darkTheme: redTheme, // Change this to: redTheme, blueTheme, or greenTheme
      home: MyHomePage(),
    );
  }
}

// Theme 1: Red Theme
final ThemeData redTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Colors.red,
    surface: Colors.red[50]!,
    onSurface: Colors.red[900]!,
  ),
  scaffoldBackgroundColor: Colors.red[50],
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.red[900], fontSize: 28),
  ),
);

// Theme 2: Blue Theme
final ThemeData blueTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Colors.blue,
    surface: Colors.blue[100]!,
    onSurface: Colors.blue[800]!,
  ),
  scaffoldBackgroundColor: Colors.blue[100],
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.blue[800], fontSize: 32),
  ),
);

// Theme 3: Green Theme
final ThemeData greenTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: Colors.green,
    surface: Colors.green[900]!,
    onSurface: Colors.green[100]!,
  ),
  scaffoldBackgroundColor: Colors.green[900],
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.green[100], fontSize: 24),
  ),
);

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Theme Demo')),
      body: Center(
        child: Container(
          // color: Theme.of(context).colorScheme.surface,
          child: Text(
            'Hello World!',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
