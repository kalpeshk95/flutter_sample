import 'package:flutter/material.dart';
import 'package:flutter_sample/core/theme/text_style_extensions.dart';
import 'package:flutter_sample/ui/screens/profile/profile_validators.dart';

import '../../../../core/theme/app_typography.dart';
import '../../../shared/widgets/custom_text_field.dart';

class ProfileForm extends StatelessWidget {

  const ProfileForm({
    required this.formKey, required this.nameController, required this.emailController, required this.phoneController, required this.dobController, required this.onSelectDate, super.key,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController dobController;
  final Future<void> Function() onSelectDate;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: _buildBoxDecoration(colorScheme),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(colorScheme),
            const SizedBox(height: 16),
            ..._buildFormFields(),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration(ColorScheme colorScheme) {
    return BoxDecoration(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(ColorScheme colorScheme) {
    return Text(
      'Personal Information',
      style: AppTypography.eighteen.bold.withColor(colorScheme.onSurface),
    );
  }

  List<Widget> _buildFormFields() {
    return [
      _buildTextField(
        controller: nameController,
        label: 'Full Name',
        icon: Icons.person_outline,
        validator: ProfileValidators.validateName,
      ),
      const SizedBox(height: 16),
      _buildTextField(
        controller: emailController,
        label: 'Email',
        icon: Icons.email_outlined,
        keyboardType: TextInputType.emailAddress,
        validator: ProfileValidators.validateEmail,
      ),
      const SizedBox(height: 16),
      _buildTextField(
        controller: phoneController,
        label: 'Phone Number',
        icon: Icons.phone_android_outlined,
        keyboardType: TextInputType.phone,
        validator: ProfileValidators.validatePhone,
      ),
      const SizedBox(height: 16),
      _buildDateField(),
    ];
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool readOnly = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return CustomTextField(
      controller: controller,
      label: label,
      icon: icon,
      readOnly: readOnly,
      keyboardType: keyboardType,
      validator: validator,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    );
  }

  Widget _buildDateField() {
    return GestureDetector(
      onTap: onSelectDate,
      child: AbsorbPointer(
        child: _buildTextField(
          controller: dobController,
          label: 'Date of Birth',
          icon: Icons.calendar_today_outlined,
          readOnly: true,
        ),
      ),
    );
  }
}
