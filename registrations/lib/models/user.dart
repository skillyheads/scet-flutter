class User {
  String _name;
  String _email;
  String _mobileNumber;
  String get name => _name;
  String get email => _email;
  String get mobileNumber => _mobileNumber;
  set name(String name) => _name = name;
  set email(String email) => _email = email;
  set mobileNumber(String name) => _mobileNumber = mobileNumber;
  User() : _name = '', _email = '', _mobileNumber = '';
}
