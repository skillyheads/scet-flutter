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

  // Light theme
  ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.teal,
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
      elevation: 2,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.teal, width: 2),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.teal;
        }
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.teal;
        }
        return null;
      }),
    ),
  );

  // Dark theme
  ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.teal,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.teal.shade700,
      foregroundColor: Colors.white,
      elevation: 2,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal.shade600,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.teal.shade400, width: 2),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.teal.shade400;
        }
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.teal.shade400;
        }
        return null;
      }),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Registration Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode
          .system, // Change to ThemeMode.light or ThemeMode.dark to force a theme
      initialRoute: '/',
      routes: {
        "/": (context) => HomePage(title: 'Registrations'),
        "/list-users": (context) => ListUsers(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({required this.title, super.key});
  final title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserRegistrations userRegistrations = UserRegistrations();
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadInitialUsers();
  }

  Future<void> _loadInitialUsers() async {
    await userRegistrations.loadUsers();
    setState(() {
      _isLoading = false;
    });
  }

  void _registrationSuccess() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/list-users',
                arguments: userRegistrations,
              );
            },
            icon: Icon(Icons.list),
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
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : RegisteredUsers(registrations: userRegistrations),
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
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              obscureText: false,
              decoration: InputDecoration(labelText: 'Name'),
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
              decoration: InputDecoration(labelText: 'Email'),
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
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedDept,
              decoration: InputDecoration(labelText: 'Department'),
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

  RegisteredUsers({required this.registrations, super.key}) {
    registrations.loadUsers();
  }

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
                    border: Border.all(
                      width: 2,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    borderRadius: BorderRadius.circular(50),
                    color: user.gender == 'Male'
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                  ),
                  height: 50,
                  width: 50,
                  child: Center(
                    child: Text(
                      user.email[0].toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.email,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      user.department,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
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
