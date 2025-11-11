abstract class Validator {
  // TODO : Validate Username

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
}
