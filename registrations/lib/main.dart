import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:registrations/models/user.dart';
import 'package:registrations/screens/list_users.dart';
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
      //home: const MyWidget(title: 'Registrations'),
      initialRoute: '/',
      routes: {
        "/": (context) => MyWidget(title: 'Registrations'),
        "/list-users": (context) => ListUsers(),
      },
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({required this.title, super.key});
  final title;

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final UserRegistrations userRegistrations = UserRegistrations();
  void _registrationSuccess() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/list-users',
                arguments: userRegistrations,
              );
            },
            child: Icon(Icons.list),
          ),
        ],
      ),
      body: Column(
        children: [
          Registration(
            title: 'User Registration',
            registrations: userRegistrations,
            onSuccess: _registrationSuccess,
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
    required this.onSuccess,
  });
  final UserRegistrations registrations;
  final VoidCallback onSuccess;
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String _gender = "Male";
  String _selectedDept = "NA";
  List<String> departments = ["CSE", "AIML", "ECE", "IT", "AIDS", "EEE", "NA"];
  bool _isAgreed = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            RadioListTile(
              title: Text('Male'),
              value: 'Male',
              groupValue: _gender,
              contentPadding: EdgeInsets.all(1),
              onChanged: (String? value) {
                setState(() {
                  _gender = value!;
                });
              },
              activeColor: Colors.cyanAccent.shade400,
            ),
            RadioListTile(
              title: Text('Female'),
              value: 'Female',
              groupValue: _gender,
              contentPadding: EdgeInsets.all(1),
              onChanged: (String? value) {
                setState(() {
                  _gender = value!;
                });
              },
              activeColor: Colors.cyanAccent.shade400,
            ),
            RadioListTile(
              title: Text('Neutral'),
              value: 'Neutral',
              groupValue: _gender,
              contentPadding: EdgeInsets.all(1),
              onChanged: (String? value) {
                setState(() {
                  _gender = value!;
                });
              },
              activeColor: Colors.cyanAccent.shade400,
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedDept,
              items: [
                ...departments.map((String dept) {
                  return DropdownMenuItem<String>(
                    value: dept,
                    child: Text(dept),
                  );
                }),
              ],
              onChanged: (String? selectedDept) {
                _selectedDept = selectedDept ?? "NA";
              },
            ),
            CheckboxListTile(
              title: Text('I agree to the terms and conditions'),
              value: _isAgreed,
              onChanged: (bool? value) {
                setState(() {
                  _isAgreed = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (_isAgreed) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Form is valid!')));
                    User user = User();
                    user.name = _nameController.text;
                    user.email = _emailController.text;
                    user.gender = _gender;
                    user.department = _selectedDept;
                    widget.registrations.addUser(user);
                    widget.onSuccess();
                  } else {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Agree the terms!')));
                  }
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
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(50),
                    color: user.gender == 'Male'
                        ? Colors.teal
                        : Colors.pink.shade50,
                  ),
                  height: 50,
                  width: 50,
                  child: Center(child: Text(user.email[0].toUpperCase())),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name),
                    Text(user.email),
                    Text(user.department),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
