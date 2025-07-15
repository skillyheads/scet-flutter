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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: HomePage(title: 'Simple Form'),
    );
  }
}

class HomePage extends StatelessWidget {
  String title;
  HomePage({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(child: EnrollForm()),
    );
  }
}

class EnrollForm extends StatefulWidget {
  const EnrollForm({super.key});

  @override
  State<EnrollForm> createState() => _EnrollFormState();
}

class _EnrollFormState extends State<EnrollForm> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
