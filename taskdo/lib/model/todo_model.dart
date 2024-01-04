import 'package:flutter/material.dart';

class TodoModel {
  String title;
  DateTime date;
  TimeOfDay? time;
  String? docId;
  bool isChecked;

  TodoModel({
    required this.title,
    required this.date,
    this.time,
    this.docId,
    this.isChecked = false,
  });

  void toggleDone() {
    isChecked = !isChecked;
  }
}
