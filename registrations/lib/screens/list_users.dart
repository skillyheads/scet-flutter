import 'package:flutter/material.dart';
import 'package:registrations/main.dart';
import 'package:registrations/services/user_registrations.dart';

class ListUsers extends StatelessWidget {
  const ListUsers({super.key});

  @override
  Widget build(BuildContext context) {
    final registrations =
        ModalRoute.of(context)!.settings.arguments as UserRegistrations;
    return Scaffold(
      appBar: AppBar(title: Text('Title Bar')),
      body: RegisteredUsers(registrations: registrations),
    );
  }
}
