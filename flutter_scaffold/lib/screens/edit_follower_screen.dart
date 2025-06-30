import 'package:flutter/material.dart';
import '../models/follower.dart';
import '../widgets/avatar_picker.dart';
import '../themes/app_theme.dart';
import '../utils/responsive_utils.dart';

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
      builder: (context) => AvatarPicker(
        selectedAvatar: _selectedAvatar,
        onAvatarSelected: (avatar) {
          setState(() {
            _selectedAvatar = avatar;
          });
          _checkForChanges();
        },
        accentColor: AppColors.editFormAccent,
      ),
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
                color: AppColors.deleteAccent.shade600,
                size: 28,
              ),
              SizedBox(width: 8),
              Text(
                'Delete Follower',
                style: TextStyle(
                  color: AppColors.deleteAccent.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to delete "${widget.follower.name}"? This action cannot be undone.',
            style: TextStyle(
              fontSize: ResponsiveUtils.getFontSize(context, 16),
            ),
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
                Navigator.pop(context);
                Navigator.pop(context, 'deleted');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.deleteAccent.shade600,
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
    final isLargeScreen = ResponsiveUtils.isTablet(context);
    final padding = ResponsiveUtils.getCardPadding(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Follower'),
        actions: [
          IconButton(
            onPressed: _showDeleteConfirmation,
            icon: Icon(
              Icons.delete_outline,
              color: AppColors.deleteAccent.shade600,
            ),
            tooltip: 'Delete Follower',
          ),
          if (_hasChanges)
            TextButton(
              onPressed: _updateFollower,
              child: Text(
                'UPDATE',
                style: TextStyle(
                  color: AppColors.editFormAccent.shade700,
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
              SizedBox(height: 20),
              _buildDeleteButton(isLargeScreen),
              SizedBox(height: 12),
              _buildUpdateSection(isLargeScreen),
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
        color: AppColors.editFormAccent.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.editFormAccent.shade200),
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
                color: AppColors.editFormAccent.shade100,
                border: Border.all(
                  color: AppColors.editFormAccent.shade300,
                  width: 3,
                ),
              ),
              child: _selectedAvatar != null
                  ? ClipOval(
                      child: Image.asset(
                        _selectedAvatar!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildFallbackAvatar(avatarSize);
                        },
                      ),
                    )
                  : _buildFallbackAvatar(avatarSize),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tap to change avatar',
            style: TextStyle(
              fontSize: ResponsiveUtils.getFontSize(context, 12),
              color: AppColors.editFormAccent.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Edit Details',
            style: TextStyle(
              fontSize: ResponsiveUtils.getFontSize(context, 20),
              fontWeight: FontWeight.bold,
              color: AppColors.editFormAccent.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackAvatar(double size) {
    return CircleAvatar(
      radius: (size - 6) / 2,
      backgroundColor: AppColors.editFormAccent.shade100,
      child: Text(
        widget.follower.name.isNotEmpty
            ? widget.follower.name[0].toUpperCase()
            : '?',
        style: TextStyle(
          fontSize: size * 0.4,
          fontWeight: FontWeight.bold,
          color: AppColors.editFormAccent.shade700,
        ),
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

  Widget _buildDeleteButton(bool isLargeScreen) {
    return Container(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: _showDeleteConfirmation,
        icon: Icon(
          Icons.delete_forever,
          color: AppColors.deleteAccent.shade600,
        ),
        label: Text(
          'Delete Follower',
          style: TextStyle(
            color: AppColors.deleteAccent.shade600,
            fontWeight: FontWeight.w600,
            fontSize: ResponsiveUtils.getFontSize(context, 16),
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.deleteAccent.shade300, width: 1.5),
          padding: EdgeInsets.symmetric(vertical: isLargeScreen ? 16 : 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildUpdateSection(bool isLargeScreen) {
    if (_hasChanges) {
      return ElevatedButton(
        onPressed: _updateFollower,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.editFormAccent.shade600,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: isLargeScreen ? 20 : 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Text(
          'Update Follower',
          style: TextStyle(
            fontSize: ResponsiveUtils.getFontSize(context, 18),
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(vertical: isLargeScreen ? 20 : 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'No changes made',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: ResponsiveUtils.getFontSize(context, 16),
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }
  }
}
