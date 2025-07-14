import 'package:registrations/models/user.dart';
import 'package:registrations/services/firebase_service.dart';

class UserRegistrations {
  List<User> users = [];
  FirestoreUserService userService = FirestoreUserService();
  addUser(User user) {
    users.add(user);
    userService.createUser(user);
  }

  loadUsers() async {
    List<User> firebaseUsers = await userService.getAllUsers();
    users.addAll(firebaseUsers);
  }
}
