import 'package:flutter/material.dart';

import '../model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  // List<bool> isCheckedList = [];
  // List<TodoModel> checkedList = [];

  // void getTask(String title) {
  //   addTask.insert(
  //     0,TodoModel(title: title),
  //   );
  //   notifyListeners();
  // }

  // void toggleBox(TodoModel checked) {
  //   if (checkedList.contains(checked)) {
  //     checkedList.remove(checked);
  //   } else {
  //     checkedList.add(checked);
  //   }
  //   notifyListeners();
  // }

  void toggleCheckedBox(TodoModel tasks) {
    tasks.toggleDone();
    notifyListeners();
  }

  // void toggleBox(int index){
  //   isCheckedList[index] = !isCheckedList[index];
  //   notifyListeners();
  // }

  // void toggleContainerColor(TodoModel changeColor) {
  //   notifyListeners();
  // }
}
