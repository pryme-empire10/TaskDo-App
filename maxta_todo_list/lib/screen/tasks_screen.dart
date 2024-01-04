import 'package:flutter/material.dart';

import '../consts/colors.dart';
import '../consts/sized_box.dart';
import '../consts/text_string.dart';
import '../consts/text_style.dart';
import '../model/todo_model.dart';
import '../provider/todo_provider.dart';
import '../widget/add_task_button.dart';
import '../widget/text_input_entry.dart';

// ignore: must_be_immutable
class TaskScreen extends StatefulWidget {
  TaskScreen({
    super.key,
    required this.currentTask,
    required this.todoProvider,
  });

  TodoModel currentTask;
  TodoProvider todoProvider;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController _titleController = TextEditingController();

  // final TextEditingController _subTitleController = TextEditingController();

  String text = 'Please enter a task title.';

  bool errorMessage = false;

  void handleTitleInput(context) {
    if (_titleController.text.isEmpty) {
      setState(() {
        errorMessage = true;
      });
    } else {
      widget.todoProvider
          .getTask(widget.currentTask.title);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: const Text(kNewTask),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              kTaskName,
              style: AppStyle.kTaskHeader,
            ),
            buildSizeBox(15, 0),
            TextInputEntry(
              controller: _titleController,
              hintText: kAddTaskName,
              keyboardType: TextInputType.multiline,
              onChanged: (value) {
                setState(() {
                  widget.currentTask.title = value;
                  errorMessage = false;
                });
              },
            ),
            errorMessage
                ? Text(
                    text,
                    style: const TextStyle(color: Colors.red),
                  )
                : const SizedBox(),
            buildSizeBox(30, 0),
            // Text(
            //   kDescription,
            //   style: AppStyle.kTaskHeader,
            // ),
            // buildSizeBox(15, 0),
            // TextInputEntry(
            //   controller: _subTitleController,
            //   keyboardType: TextInputType.multiline,
            //   minLines: 5,
            //   hintText: kAddTaskDetails,
            //   onChanged: (value) {
            //     widget.currentTask.subTitle = value;
            //   },
            // ),
            // buildSizedBox(25, 0),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: AppColors.mainColor,
            //     minimumSize: const Size(500, 50),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(15),
            //     ),
            //   ),
            //   onPressed: () {},
            //   child: Text(
            //     'Save Task',
            //     style: AppStyle.kSaveTaskButton,
            //   ),
            // )
          ],
        ),
      ),
      bottomNavigationBar: AddTaskButton(
        onTap: () {
         handleTitleInput(context);
        },
        text: kSaveTask,
      ),
    );
  }
}
