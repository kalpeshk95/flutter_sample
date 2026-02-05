class ProfileValidators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }

    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      return 'Name cannot be just spaces';
    }

    if (trimmedValue.length < 5) {
      return 'Name is too short';
    }
    if (trimmedValue.length > 50) {
      return 'Name is too long (max 50 characters)';
    }

    if (!trimmedValue.contains(' ')) {
      return 'Please enter both first and last name';
    }

    if (trimmedValue.contains('  ')) {
      return 'Name cannot contain consecutive spaces';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    final digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
    final indianMobileRegex = RegExp(r'^(?:\+?91|0?)?[6-9]\d{9}$');

    if (!indianMobileRegex.hasMatch(digitsOnly)) {
      if (digitsOnly.length < 10) return 'Phone number is too short';
      if (digitsOnly.length > 13) return 'Phone number is too long';
      if (!RegExp(r'^[6-9]').hasMatch(digitsOnly) &&
          !digitsOnly.startsWith('0') &&
          !digitsOnly.startsWith('91') &&
          !digitsOnly.startsWith('+91')) {
        return 'Must start with 6, 7, 8, or 9';
      }
      return 'Please enter a valid Indian phone number';
    }

    return null;
  }
}
