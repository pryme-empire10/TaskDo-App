
import 'package:flutter/material.dart';

import '../model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> addTask = [];
 
  void getTask(String title) {
    addTask.insert(
      0,TodoModel(title: title),
    );
    notifyListeners();
  }

  void toggleCheckedBox(TodoModel checked) {
    checked.isChecked = !checked.isChecked;
    notifyListeners();
  }

  void toggleContainerColor(TodoModel changeColor) {
    changeColor.isChangeContainerColor = !changeColor.isChangeContainerColor;
    notifyListeners();
  }
}
