/// Validators utility for input validation
/// Clean architecture approach for reusable validation logic
abstract class Validators {
  /// Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final email = value.trim();
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Password validation - minimum 8 characters with mix of uppercase, lowercase, number
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character (!@#\$%^&*)';
    }

    return null;
  }

  /// Phone number validation - Pakistan format (11-12 digits or with +92)
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final phone = value.trim().replaceAll(RegExp(r'[^\d+]'), '');

    // Pakistan phone formats: 03001234567, +923001234567, 03-00-1234567
    if (phone.startsWith('+92')) {
      if (phone.length != 13) {
        return 'Invalid phone number format (+92XXXXXXXXXX)';
      }
    } else if (phone.startsWith('03')) {
      if (phone.length != 11) {
        return 'Invalid phone number format (03001234567)';
      }
    } else {
      return 'Phone number must start with 03 or +92';
    }

    return null;
  }

  /// Account number validation - for mobile payments (JazzCash/EasyPaisa)
  static String? validateAccountNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Account number is required';
    }

    final account = value.trim().replaceAll(RegExp(r'[^\d]'), '');

    if (account.length < 10 || account.length > 15) {
      return 'Account number must be between 10-15 digits';
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(account)) {
      return 'Account number must contain only digits';
    }

    return null;
  }

  /// Confirm password validation
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  /// General text validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Number validation
  static String? validateNumber(String? value, {String fieldName = 'Number', int? minValue, int? maxValue}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }

    final number = int.tryParse(value.trim());
    if (number == null) {
      return '$fieldName must be a valid number';
    }

    if (minValue != null && number < minValue) {
      return '$fieldName must be at least $minValue';
    }

    if (maxValue != null && number > maxValue) {
      return '$fieldName must not exceed $maxValue';
    }

    return null;
  }

  /// Name validation
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }

    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }

    if (!RegExp(r"^[a-zA-Z\s\-']+$").hasMatch(value)) {
      return 'Name can only contain letters, spaces, hyphens, and apostrophes';
    }

    return null;
  }

  /// Salary validation
  static String? validateSalary(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Salary is optional
    }

    final salary = double.tryParse(value.trim());
    if (salary == null) {
      return 'Please enter a valid salary amount';
    }

    if (salary < 0) {
      return 'Salary cannot be negative';
    }

    return null;
  }

  /// Check password strength
  static PasswordStrength checkPasswordStrength(String password) {
    int strength = 0;

    if (password.length >= 8) strength++;
    if (password.length >= 12) strength++;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength++;
    if (RegExp(r'[a-z]').hasMatch(password)) strength++;
    if (RegExp(r'[0-9]').hasMatch(password)) strength++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) strength++;

    if (strength <= 2) return PasswordStrength.weak;
    if (strength <= 4) return PasswordStrength.medium;
    return PasswordStrength.strong;
  }
}

/// Password strength enum
enum PasswordStrength { weak, medium, strong }

extension PasswordStrengthExtension on PasswordStrength {
  String get label {
    switch (this) {
      case PasswordStrength.weak:
        return 'Weak';
      case PasswordStrength.medium:
        return 'Medium';
      case PasswordStrength.strong:
        return 'Strong';
    }
  }

  int get color {
    switch (this) {
      case PasswordStrength.weak:
        return 0xFFFF5252;
      case PasswordStrength.medium:
        return 0xFFFFC107;
      case PasswordStrength.strong:
        return 0xFF4CAF50;
    }
  }
}
