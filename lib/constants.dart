class AppConstants {
  // static const String FONT = "Poppins";
  // Form Error
  static final RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const String kEmailNullError = "Please Enter your email";
  static const String kInvalidEmailError = "Please Enter Valid Email";
  static const String kPassNullError = "Please Enter your password";
  static const String kShortPassError = "Password is too short";
  static const String kMatchPassError = "Passwords don't match";
  static const String kNamelNullError = "Please Enter your name";
  static const String kPhoneNumberNullError = "Please Enter your phone number";

  static const String hot = "HotNewsPage";
  static const String all = "AllNewsPage";
  static const String technology = "TechnolotyNewsPage";
  static const String civil = "CivilNewsPage";
  static const String entertainment = "EntertainmentNewsPage";
}

enum NewsCategory {
  all,
  news,
  world,
  social,
  law,
  business,
  sport,
  health,
  entertainment,
  trending,
  peoplemayread,
  notification
}
