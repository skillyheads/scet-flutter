class User {
  String _name;
  String _email;
  User() : _name = '', _email = '';
  String get name => _name;
  set name(String name) => _name = name;
  String get email => _email;
  set email(String email) => _email = email;
}
