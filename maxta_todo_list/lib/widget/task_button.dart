import 'package:flutter/material.dart';

import '../consts/colors.dart';
import '../consts/text_style.dart';
import '../provider/todo_provider.dart';

// ignore: must_be_immutable
class TaskButton extends StatelessWidget {
  TaskButton({
    super.key,
    required this.currentTask,
  });

  TodoProvider currentTask;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(50, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: AppColors.mainColor,
      ),
      onPressed: () {},
      child: Text(
        'Add Task',
        style: AppStyle.kAddTask,
      ),
    );
  }
}
