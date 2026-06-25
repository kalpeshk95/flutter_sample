import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sample/core/theme/text_style_extensions.dart';

import '../../../../core/theme/app_typography.dart';

class ProfileHeader extends StatelessWidget {

  const ProfileHeader({
    required this.onPickImage, super.key,
    this.name,
    this.email,
    this.imageFile,
    this.imagePath,
  });
  final String? name;
  final String? email;
  final File? imageFile;
  final String? imagePath;
  final VoidCallback onPickImage;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Background decoration
            Container(
              height: 180,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 36),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary.withAlpha(26),
                    colorScheme.secondary.withAlpha(26),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            _buildProfileContent(colorScheme),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileContent(ColorScheme colorScheme) {
    return Column(
      children: [
        _buildProfileImage(colorScheme),
        const SizedBox(height: 16),
        _buildUserInfo(colorScheme),
      ],
    );
  }

  Widget _buildProfileImage(ColorScheme colorScheme) {
    return GestureDetector(
      onTap: onPickImage,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: colorScheme.primary,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(26),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipOval(
          child: _buildImageContent(colorScheme),
        ),
      ),
    );
  }

  Widget _buildImageContent(ColorScheme colorScheme) {
    if (imageFile != null) {
      return Image.file(
        imageFile!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholderIcon(colorScheme),
      );
    } else if (imagePath != null) {
      return Image.file(
        File(imagePath!),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholderIcon(colorScheme),
      );
    } else {
      return _buildPlaceholderIcon(colorScheme);
    }
  }

  Widget _buildPlaceholderIcon(ColorScheme colorScheme) {
    return Container(
      color: colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.person,
        size: 50,
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildUserInfo(ColorScheme colorScheme) {
    final displayName = name?.isNotEmpty == true ? name : 'Your Name';
    final displayEmail = email?.isNotEmpty == true ? email : 'email@example.com';

    return Column(
      children: [
        Text(
          displayName!,
          style: AppTypography.twentyFour.bold.withColor(colorScheme.onSurface),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          displayEmail!,
          style: AppTypography.fourteen.medium.withColor(colorScheme.onSurfaceVariant),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
