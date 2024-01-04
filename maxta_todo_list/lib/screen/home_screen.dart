
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import 'package:provider/provider.dart';

import '../consts/colors.dart';
import '../consts/text_string.dart';
import '../consts/text_style.dart';
import '../model/todo_model.dart';
import '../provider/todo_provider.dart';
import '../widget/add_task_button.dart';
import '../widget/task_container.dart';
import 'tasks_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final DateTime now = DateTime.now();

  final formatter = DateFormat('d MMMM');

  @override
  Widget build(BuildContext context) {
    final currentTask = Provider.of<TodoProvider>(context);
    return Scaffold(
      // floatingActionButton: AddTaskButton(
      //   onPressed: () {},
      //   child: const Icon(
      //     Icons.add,
      //   ),
      // ),
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (currentTask.addTask.isEmpty)
              Container(
                padding: const EdgeInsets.only(left: 100,right: 100,top: 200,bottom: 100),
                child: Text(
                  kNothingToDo,
                  style: AppStyle.kNothingToDo,
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: currentTask.addTask.length,
                itemBuilder: (context, index) {
                  final task = currentTask.addTask[index];

                  return TaskContainer(
                    task: task,
                    currentTask: currentTask,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AddTaskButton(
        text: kAddNewTask,
        onTap: () {
          TodoModel newTask = TodoModel(title: '');
          Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                duration: const Duration(milliseconds: 400),
                reverseDuration: const Duration(milliseconds: 400),
                child: TaskScreen(
                  currentTask: newTask,
                  todoProvider: currentTask,
                ),
                ctx: context,
              ));
        },
      ),
    );
  }
}
