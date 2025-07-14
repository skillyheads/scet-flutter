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
      home: LoginScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class LoginScreen extends StatelessWidget {
  String title;
  LoginScreen({super.key, this.title = ""});

  @override
  Widget build(BuildContext context) {
    return const Login();
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Screen')),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text('Login Form'),
            SizedBox(height: 20),
            TextFormField(
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.length < 3) {
                  return "Name should atleast have 3 characters";
                }
                return null;
              },
              controller: _nameController,
            ),
            SizedBox(height: 20),
            TextFormField(
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.length < 3) {
                  return "Password should atleast have 3 characters";
                }
                return null;
              },
              controller: _passwordController,
            ),
            ElevatedButton(onPressed: () {}, child: Text('Login')),
          ],
        ),
      ),
    );
  }
}
