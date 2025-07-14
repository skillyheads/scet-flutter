class User {
  String _name;
  String _email;
  String _mobileNumber;
  String _gender;
  String department;
  String get name => _name;
  String get email => _email;
  String get mobileNumber => _mobileNumber;
  String get gender => _gender;
  set name(String name) => _name = name;
  set email(String email) => _email = email;
  set mobileNumber(String name) => _mobileNumber = mobileNumber;
  set gender(String gender) => _gender = gender;
  String? id; // Firestore document ID
  DateTime? createdAt;
  DateTime? updatedAt;
  User()
    : _name = '',
      _email = '',
      _mobileNumber = '',
      _gender = 'Male',
      department = '';

  User.withData({
    required String name,
    required String email,
    required String mobileNumber,
    required String gender,
    required this.department,
    this.id,
    this.createdAt,
    this.updatedAt,
  }) : _name = name,
       _email = email,
       _mobileNumber = mobileNumber,
       _gender = gender;

  Map<String, dynamic> toFirestoreJson() {
    return {
      'fields': {
        'name': {'stringValue': _name},
        'email': {'stringValue': _email},
        'mobileNumber': {'stringValue': _mobileNumber},
        'gender': {'stringValue': _gender},
        'department': {'stringValue': department},
        'createdAt': {
          'timestampValue': (createdAt ?? DateTime.now())
              .toUtc()
              .toIso8601String(),
        },
        'updatedAt': {
          'timestampValue': (updatedAt ?? DateTime.now())
              .toUtc()
              .toIso8601String(),
        },
      },
    };
  }

  factory User.fromFirestoreJson(
    Map<String, dynamic> json, {
    String? documentId,
  }) {
    final fields = json['fields'] ?? {};

    return User.withData(
      name: fields['name']?['stringValue'] ?? '',
      email: fields['email']?['stringValue'] ?? '',
      mobileNumber: fields['mobileNumber']?['stringValue'] ?? '',
      gender: fields['gender']?['stringValue'] ?? 'Male',
      department: fields['department']?['stringValue'] ?? '',
      id: documentId,
      createdAt: fields['createdAt']?['timestampValue'] != null
          ? DateTime.parse(fields['createdAt']['timestampValue'])
          : null,
      updatedAt: fields['updatedAt']?['timestampValue'] != null
          ? DateTime.parse(fields['updatedAt']['timestampValue'])
          : null,
    );
  }
}
