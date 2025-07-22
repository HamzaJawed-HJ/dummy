class Validator {
  static bool isValidPhone(String value) {
    final phoneRegex = RegExp(r'^[0-9]{11}$');
    return phoneRegex.hasMatch(value);
  }

  static bool isValidPassword(String value) {
    return value.length >= 6;
  }

  static bool isValidCNIC(String value) {
    final cnicRegex = RegExp(r'^[0-9]{5}[0-9]{7}[0-9]$');
    return cnicRegex.hasMatch(value);
  }

  static bool isValidEmail(String value) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(value);
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Custom validators
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!isValidEmail(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!isValidPhone(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (!isValidPassword(value)) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validateCNIC(String? value) {
    if (value == null || value.isEmpty) {
      return 'CNIC is required';
    }
    if (!isValidCNIC(value)) {
      return 'Enter a valid CNIC';
    }
    return null;
  }
}
