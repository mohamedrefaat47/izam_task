import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

mixin ValidationMixin<T extends StatefulWidget> on State<T> {
  String _password = '';

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  bool emailValid(String userEmail) {
    return RegExp(r"^[a-zA-Z!$#^*]+.[0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(userEmail);
  }

  String? validateUserEmail(String userEmail) {
    if (userEmail.trim().isEmpty) {
      return "Email Address can't be empty";
    } else if (!emailValid(userEmail)) {
      return "Enter a valid email ex: izam.111@izam.co";
    }

    return null;
  }

  String? validatePassword(String password) {
    _password = password;
    if (password.trim().isEmpty) {
      return "Password can't be empty";
    } else if (password.length < 8) {
      return "The Password should has at least 8 chars";
    } else if (password.length >= 8 &&
        (!passwordHasSpecialChar(password) && !passwordHasNumbers(password))) {
      return "The password should contain 1 num and 1 special char";
    }
    return null;
  }

  bool passwordHasSpecialChar(String pass) {
    var chars = r'^$#^*';
    var charSet = {...chars.codeUnits};
    return pass.codeUnits.any(charSet.contains);
  }

  bool passwordHasNumbers(String pass) {
    return pass.contains(RegExp(r'[0-9]'));
  }
}
