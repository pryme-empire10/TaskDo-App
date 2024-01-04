import 'package:flutter/material.dart';

class TimeUtils {
  TimeOfDay time = TimeOfDay.now();
  Future<TimeOfDay?> getTime({
    required BuildContext context,
    String? title,
    TimeOfDay? initialTime,
    String? cancelText,
    String? confirmText,
    required TextEditingController textEditingController,
  }) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.dial,
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      cancelText: cancelText ?? "Cancel",
      confirmText: confirmText ?? "Save",
      helpText: title ?? "Select time",
      builder: (context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    return pickedTime;
  }
}
