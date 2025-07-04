import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:registrations/models/user.dart';
import 'package:registrations/services/user_registrations.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
      ),
      home: const MyWidget(title: 'Registrations'),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({required this.title, super.key});
  final title;
  @override
  Widget build(BuildContext context) {
    final UserRegistrations userRegistrations = UserRegistrations();
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        children: [
          Registration(
            title: 'User Registration',
            registrations: userRegistrations,
          ),
          RegisteredUsers(registrations: userRegistrations),
        ],
      ),
    );
  }
}

class Registration extends StatefulWidget {
  final String title;
  const Registration({
    required this.title,
    super.key,
    required this.registrations,
  });
  final UserRegistrations registrations;
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          children: [
            Align(
              child: Text(
                widget.title,
                style: TextStyle(color: Colors.teal, fontSize: 30),
              ),
            ),
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
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.length < 3) {
                  return "Email should atleast have 3 characters";
                }
                return null;
              },
              controller: _emailController,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Form is valid!')));
                  User user = User();
                  user.name = _nameController.text;
                  user.email = _emailController.text;
                  widget.registrations.addUser(user);
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisteredUsers extends StatelessWidget {
  final UserRegistrations registrations;
  const RegisteredUsers({required this.registrations, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: registrations.users.length,
        itemBuilder: (context, index) {
          User user = registrations.users[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(children: [Text(user.name), Text(user.email)]),
          );
        },
      ),
    );
  }
}
