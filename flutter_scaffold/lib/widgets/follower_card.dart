import 'package:flutter/material.dart';
import '../models/follower.dart';
import '../themes/app_theme.dart';
import '../utils/responsive_utils.dart';

class FollowerCard extends StatelessWidget {
  final Follower follower;
  final VoidCallback? onTap;

  const FollowerCard({Key? key, required this.follower, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final avatarSize = ResponsiveUtils.getAvatarSize(context);
    final cardPadding = ResponsiveUtils.getCardPadding(context);
    final isLargeScreen = ResponsiveUtils.isTablet(context);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.only(bottom: isLargeScreen ? 16 : 12),
        child: Container(
          padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.cardGradientStart, AppColors.cardGradientEnd],
            ),
          ),
          child: Row(
            children: [
              Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.avatarBorder,
                    width: isLargeScreen ? 3 : 2,
                  ),
                ),
                child: follower.avatarAsset != null
                    ? ClipOval(
                        child: Image.asset(
                          follower.avatarAsset!,
                          width: avatarSize,
                          height: avatarSize,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildFallbackAvatar(avatarSize);
                          },
                        ),
                      )
                    : _buildFallbackAvatar(avatarSize),
              ),
              SizedBox(width: isLargeScreen ? 20 : 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      follower.name,
                      style: TextStyle(
                        fontSize: ResponsiveUtils.getFontSize(context, 18),
                        fontWeight: FontWeight.bold,
                        color: AppColors.nameColor,
                      ),
                    ),
                    SizedBox(height: isLargeScreen ? 6 : 4),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          size: ResponsiveUtils.getFontSize(context, 16),
                          color: AppColors.phoneColor,
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            follower.mobileNumber,
                            style: TextStyle(
                              fontSize: ResponsiveUtils.getFontSize(
                                context,
                                16,
                              ),
                              color: AppColors.phoneColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.arrowIcon,
                size: ResponsiveUtils.getFontSize(context, 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackAvatar(double size) {
    return CircleAvatar(
      radius: (size - 4) / 2,
      backgroundColor: AppColors.avatarBackground,
      child: Text(
        follower.name.isNotEmpty ? follower.name[0].toUpperCase() : '?',
        style: TextStyle(
          fontSize: size * 0.4,
          fontWeight: FontWeight.bold,
          color: AppColors.avatarText,
        ),
      ),
    );
  }
}
