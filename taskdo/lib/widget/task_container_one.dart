import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:taskdo/consts/sized_box.dart';
import 'package:taskdo/services/firebase_service.dart';

import '../consts/colors.dart';
import '../consts/text_style.dart';
import '../model/todo_model.dart';
import '../provider/todo_provider.dart';
import '../screen/tasks_screen.dart';

// ignore: must_be_immutable
class TaskContainerOne extends StatelessWidget {
  TaskContainerOne({
    super.key,
    required this.tasks,
    this.docID,
  });
  final TodoModel tasks;

  final String? docID;

  FirebaseService firebaseService = FirebaseService();
  // late AnimationController _animationController;
  // late Animation<Offset> _slideAnimation;

  // @override
  // void initState() {
  //   super.initState();
  //   _animationController = AnimationController(
  //     vsync: this,
  //     duration: const Duration(seconds: 2),
  //   );
  //   _slideAnimation = Tween<Offset>(
  //     begin: Offset.zero,
  //     end: const Offset(1.0, 0.0),
  //   ).animate(
  //     CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
  //   );
  // }

  // @override
  // void dispose() {
  //   _animationController.dispose();
  //   super.dispose();
  // }

  // void _animateAndDelete() {
  //   _animationController.forward();

  // }

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
        padding: const EdgeInsets.only(bottom: 15),
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
                    firebaseService.deletetasks(docID!);
                  });
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tasks.title,
                    style: AppStyle.kTaskTitle(),
                  ),
                  Row(
                    children: [
                      Text(
                        DateFormat.yMMMEd().format(
                          tasks.date,
                        ),
                        style: AppStyle.kTimeStyle,
                      ),
                      buildSizeBox(0, 10),
                      Text(
                        '${tasks.time != null ? tasks.time!.format(context) : ''}',
                        style: AppStyle.kTimeStyle,
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
