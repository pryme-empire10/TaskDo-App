import 'package:flutter/material.dart';

class DateTimeUtils {
  DateTime _date = DateTime.now();
  Future<DateTime?> getDate({
    required BuildContext context,
    DateTime? initialDate,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    required DateTime firstDate,
    required DateTime lastDate,
    String? helpText,
    String? cancelText,
    String? confirmText,
  }) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? _date,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    return pickedDate;
  }
}
