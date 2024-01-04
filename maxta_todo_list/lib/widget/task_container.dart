import 'package:flutter/material.dart';

import '../consts/colors.dart';
import '../consts/text_style.dart';
import '../model/todo_model.dart';
import '../provider/todo_provider.dart';

class TaskContainer extends StatelessWidget {
  const TaskContainer({
    super.key,
    required this.task,
    required this.currentTask,
  });

  final TodoModel task;
  final TodoProvider currentTask;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.only(top: 15, bottom: 20),
      decoration: BoxDecoration(
        color: task.isChangeContainerColor
            ? AppColors.secondaryColor
            : AppColors.mainColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      side: BorderSide(
                        color: AppColors.whiteColor,
                      ),
                      activeColor: AppColors.mainColor,
                      value: task.isChecked,
                      onChanged: (value) {
                        currentTask.toggleCheckedBox(task);
                        currentTask.toggleContainerColor(task);
                      },
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            style: AppStyle.kTaskTitle(task),
                          ),
                          // Text(
                          //   task.subTitle,
                          //   style: AppStyle.kTaskSubtitle(task),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
