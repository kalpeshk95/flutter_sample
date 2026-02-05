import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sample/core/theme/text_style_extensions.dart';

class ProfileImagePicker extends StatelessWidget {
  final File? imageFile;
  final String? imagePath;
  final VoidCallback onPickImage;

  const ProfileImagePicker({
    super.key,
    required this.imageFile,
    required this.imagePath,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return GestureDetector(
      onTap: onPickImage,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: colorScheme.primary.withAlpha(51),
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: colorScheme.surfaceContainerHighest,
              backgroundImage: imageFile != null
                  ? FileImage(imageFile!) as ImageProvider
                  : imagePath != null
                      ? FileImage(File(imagePath!)) as ImageProvider
                      : null,
              child: imageFile == null && imagePath == null
                  ? Icon(
                      Icons.person,
                      size: 50,
                      color: colorScheme.onSurfaceVariant,
                    )
                  : null,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.surface,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.edit,
                color: colorScheme.onPrimary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
