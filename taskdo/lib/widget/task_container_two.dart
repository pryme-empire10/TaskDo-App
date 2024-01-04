import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:taskdo/model/todo_model.dart';
import 'package:taskdo/provider/todo_provider.dart';

import '../consts/colors.dart';
import '../consts/text_style.dart';
import '../screen/tasks_screen.dart';
import '../services/firebase_service.dart';

// ignore: must_be_immutable
class TaskContainerTwo extends StatelessWidget {
  TaskContainerTwo({
    super.key,
    required this.docID,
    required this.tasks,
  });
  FirebaseService firebaseService = FirebaseService();
  final String docID;
  final TodoModel tasks;

  @override
  Widget build(BuildContext context) {
    TodoProvider todo = Provider.of<TodoProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            duration: const Duration(milliseconds: 400),
            child: TaskScreen(
              currentTask: tasks,
              docID: docID,
              todoProvider: Provider.of<TodoProvider>(
                context,
                listen: false,
              ),
            ),
            ctx: context,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
        padding: const EdgeInsets.only(top: 5,bottom: 5),
        decoration: BoxDecoration(
          color: AppColors.containerColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 3),
              spreadRadius: 1,
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              side: BorderSide(
                color: AppColors.whiteColor,
              ),
              activeColor: AppColors.blackColor,
              value: tasks.isChecked,
              onChanged: (value) {
                if (value == true) {
                  todo.toggleCheckedBox(tasks);
                  Future.delayed(const Duration(seconds: 2), () {
                    firebaseService.deletetasks(docID);
                  });
                }
              },
            ),
            Text(
              tasks.title,
              style: AppStyle.kTaskTitle(),
            ),
          ],
        ),
      ),
    );
  }
}
