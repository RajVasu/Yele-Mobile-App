class Validator {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  static final RegExp passwordRegExp = RegExp(
    // r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{8,}$',
    r'^(?=.*[a-zA-Z])(?=.*\d).{8,}([@$!%*#?&])?$',
  );
  static final RegExp _usernameRegExp = RegExp(r'^[a-zA-Z0-9_]{3,16}$');

  static String? validateEmail(String email, {String? type}) {
    if (email.isEmpty) {
      return type ?? 'Please enter email';
    } else if (!_emailRegExp.hasMatch(email)) {
      return 'Invalid email format';
    }
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is required';
    } /* else if (!passwordRegExp.hasMatch(password)) {
      return 'Password is required';
    } */
    return null;
  }

  static String? validateUsername(String username) {
    if (username.isEmpty) {
      return 'Please enter username';
    } else if (!_usernameRegExp.hasMatch(username)) {
      return 'Username can only contain letters, numbers, and underscores, and must be between 3 to 16 characters long';
    }
    return null;
  }
}
