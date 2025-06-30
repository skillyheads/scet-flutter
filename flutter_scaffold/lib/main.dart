import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Followers Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.blue),
          titleTextStyle: TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class Follower {
  final String id;
  final String name;
  final String mobileNumber;
  final String? avatarAsset; // Made nullable to allow first letter fallback

  Follower({
    required this.id,
    required this.name,
    required this.mobileNumber,
    this.avatarAsset,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mobileNumber': mobileNumber,
      'avatarAsset': avatarAsset,
    };
  }

  factory Follower.fromJson(Map<String, dynamic> json) {
    return Follower(
      id: json['id'],
      name: json['name'],
      mobileNumber: json['mobileNumber'],
      avatarAsset: json['avatarAsset'],
    );
  }
}

// Available avatar assets - Add these files to your assets/avatars/ folder
class AvatarAssets {
  static const List<String> avatars = [
    'assets/avatars/avatar1.png',
    'assets/avatars/avatar2.png',
    'assets/avatars/avatar3.png',
    'assets/avatars/avatar4.png',
    'assets/avatars/avatar5.png',
    'assets/avatars/avatar6.png',
    'assets/avatars/avatar7.png',
    'assets/avatars/avatar8.png',
    'assets/avatars/avatar9.png',
    'assets/avatars/avatar10.png',
    'assets/avatars/avatar11.png',
    'assets/avatars/avatar12.png',
  ];
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Follower> followers = [];
  List<Follower> filteredFollowers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadFollowers();
    searchController.addListener(_filterFollowers);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadFollowers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final followersJson = prefs.getStringList('followers') ?? [];

      setState(() {
        followers = followersJson
            .map((json) => Follower.fromJson(jsonDecode(json)))
            .toList();
        filteredFollowers = List.from(followers);
      });
    } catch (e) {
      print('Error loading followers: $e');
      // Initialize with empty list if there's an error
      setState(() {
        followers = [];
        filteredFollowers = [];
      });
    }
  }

  Future<void> saveFollowers() async {
    final prefs = await SharedPreferences.getInstance();
    final followersJson = followers
        .map((follower) => jsonEncode(follower.toJson()))
        .toList();
    await prefs.setStringList('followers', followersJson);
  }

  void _filterFollowers() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredFollowers = followers
          .where(
            (follower) => follower.mobileNumber.toLowerCase().contains(query),
          )
          .toList();
    });
  }

  void _addFollower(Follower newFollower) {
    setState(() {
      followers.add(newFollower);
      _filterFollowers();
    });
    saveFollowers();
  }

  void _updateFollower(Follower updatedFollower) {
    setState(() {
      final index = followers.indexWhere((f) => f.id == updatedFollower.id);
      if (index != -1) {
        followers[index] = updatedFollower;
        _filterFollowers();
      }
    });
    saveFollowers();
  }

  void _deleteFollower(String followerId) {
    setState(() {
      followers.removeWhere((f) => f.id == followerId);
      _filterFollowers();
    });
    saveFollowers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Followers'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search by mobile number...',
                prefixIcon: Icon(Icons.search, color: Colors.blue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                filled: true,
                fillColor: Colors.blue.shade50,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
        ),
      ),
      body: filteredFollowers.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  SizedBox(height: 16),
                  Text(
                    searchController.text.isEmpty
                        ? 'No followers yet'
                        : 'No followers found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (searchController.text.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        'Tap the + button to add your first follower',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: filteredFollowers.length,
              itemBuilder: (context, index) {
                return FollowerCard(
                  follower: filteredFollowers[index],
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditFollowerScreen(
                          follower: filteredFollowers[index],
                        ),
                      ),
                    );
                    if (result != null) {
                      if (result == 'deleted') {
                        _deleteFollower(filteredFollowers[index].id);
                      } else {
                        _updateFollower(result);
                      }
                    }
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFollowerScreen()),
          );
          if (result != null) {
            _addFollower(result);
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class FollowerCard extends StatelessWidget {
  final Follower follower;
  final VoidCallback? onTap;

  const FollowerCard({Key? key, required this.follower, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.only(bottom: 12),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.blue.shade50.withOpacity(0.3)],
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue.shade200, width: 2),
                ),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.blue.shade100,
                  child: Text(
                    follower.name.isNotEmpty
                        ? follower.name[0].toUpperCase()
                        : '?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      follower.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade700,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          size: 16,
                          color: Colors.green.shade600,
                        ),
                        SizedBox(width: 4),
                        Text(
                          follower.mobileNumber,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.blue.shade400,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditFollowerScreen extends StatefulWidget {
  final Follower follower;

  const EditFollowerScreen({Key? key, required this.follower})
    : super(key: key);

  @override
  _EditFollowerScreenState createState() => _EditFollowerScreenState();
}

class _EditFollowerScreenState extends State<EditFollowerScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _mobileController;
  bool _hasChanges = false;
  late String _originalName;
  late String _originalMobile;
  String? _selectedAvatar;
  late String? _originalAvatar;

  @override
  void initState() {
    super.initState();
    _originalName = widget.follower.name;
    _originalMobile = widget.follower.mobileNumber;
    _originalAvatar = widget.follower.avatarAsset;
    _selectedAvatar = widget.follower.avatarAsset;
    _nameController = TextEditingController(text: _originalName);
    _mobileController = TextEditingController(text: _originalMobile);

    _nameController.addListener(_checkForChanges);
    _mobileController.addListener(_checkForChanges);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  void _checkForChanges() {
    setState(() {
      _hasChanges =
          _nameController.text.trim() != _originalName ||
          _mobileController.text.trim() != _originalMobile ||
          _selectedAvatar != _originalAvatar;
    });
  }

  void _updateFollower() {
    if (_formKey.currentState!.validate()) {
      final updatedFollower = Follower(
        id: widget.follower.id,
        name: _nameController.text.trim(),
        mobileNumber: _mobileController.text.trim(),
        avatarAsset: _selectedAvatar,
      );
      Navigator.pop(context, updatedFollower);
    }
  }

  void _showAvatarPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Choose Avatar',
            style: TextStyle(
              color: Colors.orange.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            width: double.maxFinite,
            height: 300,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: AvatarAssets.avatars.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  // "No Avatar" option
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatar = null;
                      });
                      _checkForChanges();
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _selectedAvatar == null
                              ? Colors.orange
                              : Colors.grey.shade300,
                          width: _selectedAvatar == null ? 3 : 1,
                        ),
                        color: Colors.grey.shade100,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person_outline,
                          size: 40,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  );
                }

                final avatarPath = AvatarAssets.avatars[index - 1];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedAvatar = avatarPath;
                    });
                    _checkForChanges();
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _selectedAvatar == avatarPath
                            ? Colors.orange
                            : Colors.grey.shade300,
                        width: _selectedAvatar == avatarPath ? 3 : 1,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        avatarPath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade200,
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.grey.shade400,
                              size: 30,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.red.shade600,
                size: 28,
              ),
              SizedBox(width: 8),
              Text(
                'Delete Follower',
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to delete "${widget.follower.name}"? This action cannot be undone.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(
                  context,
                  'deleted',
                ); // Return to home with delete signal
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Delete',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Follower'),
        actions: [
          IconButton(
            onPressed: _showDeleteConfirmation,
            icon: Icon(Icons.delete_outline, color: Colors.red.shade600),
            tooltip: 'Delete Follower',
          ),
          if (_hasChanges)
            TextButton(
              onPressed: _updateFollower,
              child: Text(
                'UPDATE',
                style: TextStyle(
                  color: Colors.orange.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _showAvatarPicker,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.orange.shade100,
                          border: Border.all(
                            color: Colors.orange.shade300,
                            width: 3,
                          ),
                        ),
                        child: _selectedAvatar != null
                            ? ClipOval(
                                child: Image.asset(
                                  _selectedAvatar!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return CircleAvatar(
                                      radius: 37,
                                      backgroundColor: Colors.orange.shade100,
                                      child: Text(
                                        widget.follower.name.isNotEmpty
                                            ? widget.follower.name[0]
                                                  .toUpperCase()
                                            : '?',
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.orange.shade700,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : CircleAvatar(
                                radius: 37,
                                backgroundColor: Colors.orange.shade100,
                                child: Text(
                                  widget.follower.name.isNotEmpty
                                      ? widget.follower.name[0].toUpperCase()
                                      : '?',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange.shade700,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tap to change avatar',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.orange.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Edit Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade800,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(color: Colors.purple.shade600),
                  prefixIcon: Icon(Icons.person, color: Colors.purple.shade600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.purple.shade600,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.purple.shade50,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  labelStyle: TextStyle(color: Colors.green.shade600),
                  prefixIcon: Icon(Icons.phone, color: Colors.green.shade600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.green.shade600,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.green.shade50,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a mobile number';
                  }
                  if (value.trim().length < 10) {
                    return 'Please enter a valid mobile number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              if (_hasChanges)
                ElevatedButton(
                  onPressed: _updateFollower,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade600,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    'Update Follower',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              else
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'No changes made',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddFollowerScreen extends StatefulWidget {
  @override
  _AddFollowerScreenState createState() => _AddFollowerScreenState();
}

class _AddFollowerScreenState extends State<AddFollowerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  String? _selectedAvatar;

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newFollower = Follower(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        mobileNumber: _mobileController.text.trim(),
        avatarAsset: _selectedAvatar,
      );
      Navigator.pop(context, newFollower);
    }
  }

  void _showAvatarPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Choose Avatar',
            style: TextStyle(
              color: Colors.blue.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Container(
            width: double.maxFinite,
            height: 300,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount:
                  AvatarAssets.avatars.length + 1, // +1 for "No Avatar" option
              itemBuilder: (context, index) {
                if (index == 0) {
                  // "No Avatar" option
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatar = null;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _selectedAvatar == null
                              ? Colors.blue
                              : Colors.grey.shade300,
                          width: _selectedAvatar == null ? 3 : 1,
                        ),
                        color: Colors.grey.shade100,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person_outline,
                          size: 40,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  );
                }

                final avatarPath = AvatarAssets.avatars[index - 1];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedAvatar = avatarPath;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _selectedAvatar == avatarPath
                            ? Colors.blue
                            : Colors.grey.shade300,
                        width: _selectedAvatar == avatarPath ? 3 : 1,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        avatarPath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade200,
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.grey.shade400,
                              size: 30,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Follower'),
        actions: [
          TextButton(
            onPressed: _submitForm,
            child: Text(
              'SAVE',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _showAvatarPicker,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.shade100,
                          border: Border.all(
                            color: Colors.blue.shade300,
                            width: 3,
                          ),
                        ),
                        child: _selectedAvatar != null
                            ? ClipOval(
                                child: Image.asset(
                                  _selectedAvatar!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.person_add,
                                      size: 40,
                                      color: Colors.blue.shade700,
                                    );
                                  },
                                ),
                              )
                            : Icon(
                                Icons.person_add,
                                size: 40,
                                color: Colors.blue.shade700,
                              ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tap to choose avatar',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'New Follower',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(color: Colors.purple.shade600),
                  prefixIcon: Icon(Icons.person, color: Colors.purple.shade600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.purple.shade600,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.purple.shade50,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _mobileController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  labelStyle: TextStyle(color: Colors.green.shade600),
                  prefixIcon: Icon(Icons.phone, color: Colors.green.shade600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.green.shade600,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.green.shade50,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a mobile number';
                  }
                  if (value.trim().length < 10) {
                    return 'Please enter a valid mobile number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  'Add Follower',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
