import 'package:flutter/material.dart';
import '../models/follower.dart';
import '../widgets/avatar_picker.dart';
import '../themes/app_theme.dart';
import '../utils/responsive_utils.dart';

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
      builder: (context) => AvatarPicker(
        selectedAvatar: _selectedAvatar,
        onAvatarSelected: (avatar) {
          setState(() {
            _selectedAvatar = avatar;
          });
        },
        accentColor: AppColors.addFormAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = ResponsiveUtils.isTablet(context);
    final padding = ResponsiveUtils.getCardPadding(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Follower'),
        actions: [
          TextButton(
            onPressed: _submitForm,
            child: Text(
              'SAVE',
              style: TextStyle(
                color: AppColors.addFormAccent,
                fontWeight: FontWeight.bold,
                fontSize: ResponsiveUtils.getFontSize(context, 16),
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildAvatarSection(isLargeScreen),
              SizedBox(height: isLargeScreen ? 40 : 32),
              _buildNameField(),
              SizedBox(height: 20),
              _buildMobileField(),
              SizedBox(height: isLargeScreen ? 40 : 32),
              _buildSubmitButton(isLargeScreen),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarSection(bool isLargeScreen) {
    final avatarSize = isLargeScreen ? 100.0 : 80.0;

    return Container(
      padding: EdgeInsets.all(isLargeScreen ? 32 : 24),
      decoration: BoxDecoration(
        color: AppColors.addFormAccent.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.addFormAccent.shade200),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: _showAvatarPicker,
            child: Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.addFormAccent.shade100,
                border: Border.all(
                  color: AppColors.addFormAccent.shade300,
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
                            size: avatarSize * 0.5,
                            color: AppColors.addFormAccent.shade700,
                          );
                        },
                      ),
                    )
                  : Icon(
                      Icons.person_add,
                      size: avatarSize * 0.5,
                      color: AppColors.addFormAccent.shade700,
                    ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tap to choose avatar',
            style: TextStyle(
              fontSize: ResponsiveUtils.getFontSize(context, 12),
              color: AppColors.addFormAccent.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'New Follower',
            style: TextStyle(
              fontSize: ResponsiveUtils.getFontSize(context, 20),
              fontWeight: FontWeight.bold,
              color: AppColors.addFormAccent.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: 'Full Name',
        labelStyle: TextStyle(color: AppColors.nameFieldColor.shade600),
        prefixIcon: Icon(
          Icons.person,
          color: AppColors.nameFieldColor.shade600,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.nameFieldColor.shade600,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: AppColors.nameFieldColor.shade50,
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter a name';
        }
        return null;
      },
    );
  }

  Widget _buildMobileField() {
    return TextFormField(
      controller: _mobileController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Mobile Number',
        labelStyle: TextStyle(color: AppColors.phoneFieldColor.shade600),
        prefixIcon: Icon(
          Icons.phone,
          color: AppColors.phoneFieldColor.shade600,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.phoneFieldColor.shade600,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: AppColors.phoneFieldColor.shade50,
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
    );
  }

  Widget _buildSubmitButton(bool isLargeScreen) {
    return ElevatedButton(
      onPressed: _submitForm,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.addFormAccent,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: isLargeScreen ? 20 : 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
      child: Text(
        'Add Follower',
        style: TextStyle(
          fontSize: ResponsiveUtils.getFontSize(context, 18),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
