abstract class Validator {
  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }

    final username = value.trim();

    if (username.length < 3) {
      return 'Username must be at least 3 characters';
    }
    if (username.length > 20) {
      return 'Username cannot be longer than 20 characters';
    }

    final regex = RegExp(r'^[a-zA-Z0-9._]+$');
    if (!regex.hasMatch(username)) {
      return 'Only letters, numbers, underscores, and dots are allowed';
    }

    if (username.contains('..') ||
        username.contains('__') ||
        username.contains('._') ||
        username.contains('_.')) {
      return 'Username cannot contain consecutive dots or underscores';
    }

    if (username.startsWith('.') ||
        username.startsWith('_') ||
        username.endsWith('.') ||
        username.endsWith('_')) {
      return 'Username cannot start or end with a dot or underscore';
    }

    return null;
  }

  static String? validateEmpty(String? data) {
    if (data?.isEmpty ?? true) {
      return "This field is required";
    }
    return null;
  }

  static String? validateEmail(String? data) {
    if (data?.isEmpty ?? true) {
      return "This field is required";
    }
    bool isNotValidEmail = !(data!.contains("@") && data.contains("."));
    if (isNotValidEmail) {
      return "Invalid Email format";
    }
    return null;
  }

  static String? validatePassword(String? data) {
    if (data?.isEmpty ?? true) {
      return "This field is required";
    }
    if (data!.length < 8) {
      return "Password must be at least 8 characters";
    }
    if (!data.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter";
    }
    if (!data.contains(RegExp(r'[a-z]'))) {
      return "Password must contain at least one lowercase letter";
    }
    if (!data.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number";
    }
    if (!data.contains(RegExp(r'[!@#$&*%^]'))) {
      return "Password must contain at least one special character";
    }
    return null;
  }

  static String? validateHabitName(String? data) {
    if (data?.isEmpty ?? true) {
      return "This field is required";
    }
    if (data!.length < 3) {
      return "Habit name must be at least 3 characters";
    }
    return null;
  }
}
