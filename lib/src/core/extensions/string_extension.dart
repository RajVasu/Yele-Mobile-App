import 'package:flutter/material.dart';

extension StringExtension on String {
  DateTime toDate() {
    DateTime date = DateTime.parse(this);
    return date;
  }

  DateTime toLocalDate() {
    return toDate().toLocal();
  }

  int get hours {
    return int.parse(split(':')[0]);
  }

  int get minutes {
    return int.parse(split(':')[1]);
  }

  TimeOfDay get time {
    return TimeOfDay(hour: hours, minute: minutes);
  }

}
  String formatEmail(String email) {
    final RegExp emailRegExp = RegExp(r'^(.+?)(@.+)$');
    if (emailRegExp.hasMatch(email)) {
      final match = emailRegExp.firstMatch(email);
      final username = match?.group(1) ?? '';
      final domain = match?.group(2) ?? '';
      String formattedUsername =
          username.length > 2
              ? username.substring(0, 2) + '*' * (username.length - 2)
              : username;
      return formattedUsername + domain;
    }
    return email;
  }
