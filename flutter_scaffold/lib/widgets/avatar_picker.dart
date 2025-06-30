import 'package:flutter/material.dart';
import '../constants/avatar_assets.dart';
import '../utils/responsive_utils.dart';

class AvatarPicker extends StatelessWidget {
  final String? selectedAvatar;
  final Function(String?) onAvatarSelected;
  final Color accentColor;

  const AvatarPicker({
    Key? key,
    required this.selectedAvatar,
    required this.onAvatarSelected,
    required this.accentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = ResponsiveUtils.isTablet(context);

    return AlertDialog(
      title: Text(
        'Choose Avatar',
        style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
      ),
      content: Container(
        width: double.maxFinite,
        height: isLargeScreen ? 400 : 300,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isLargeScreen ? 4 : 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: AvatarAssets.avatars.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildNoAvatarOption(context);
            }

            final avatarPath = AvatarAssets.avatars[index - 1];
            return _buildAvatarOption(context, avatarPath);
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
  }

  Widget _buildNoAvatarOption(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onAvatarSelected(null);
        Navigator.of(context).pop();
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: selectedAvatar == null ? accentColor : Colors.grey.shade300,
            width: selectedAvatar == null ? 3 : 1,
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

  Widget _buildAvatarOption(BuildContext context, String avatarPath) {
    return GestureDetector(
      onTap: () {
        onAvatarSelected(avatarPath);
        Navigator.of(context).pop();
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: selectedAvatar == avatarPath
                ? accentColor
                : Colors.grey.shade300,
            width: selectedAvatar == avatarPath ? 3 : 1,
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
  }
}
