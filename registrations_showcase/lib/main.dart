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
      home: const RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Registrations'), centerTitle: true),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text('Registration Form', style: TextStyle(fontSize: 30)),
          ),
          RegistrationForm(),
        ],
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                label: Text('Name'),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.length < 5) {
                  return "Name can't be smaller than 5 characters";
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                label: Text('Email'),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.length < 5) {
                  return "Email can't be smaller than 5 characters";
                }
                return null;
              },
            ),

            ElevatedButton(
              onPressed: () {
                bool isValid = _formKey.currentState!.validate();
                if (isValid) {
                  String data = _emailController.text;
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(data)));
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
