import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskdo/utils/date_time_utils.dart';
import 'package:taskdo/utils/handle_input.dart';

import '../consts/colors.dart';
import '../consts/sized_box.dart';
import '../consts/text_string.dart';
import '../consts/text_style.dart';
import '../model/todo_model.dart';
import '../provider/todo_provider.dart';
import '../services/firebase_service.dart';
import '../utils/time_utils.dart';
import '../widget/add_task_button.dart';
import '../widget/reset_container.dart';
import '../widget/text_input_entry.dart';

// ignore: must_be_immutable
class TaskScreen extends StatefulWidget {
  TaskScreen({
    super.key,
    required this.currentTask,
    required this.todoProvider,
    this.docID,
  });

  TodoModel currentTask;
  TodoProvider todoProvider;
  String? docID;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  FirebaseService firebaseService = FirebaseService();
  final TimeUtils timeUtils = TimeUtils();
  final DateTimeUtils dateUtils = DateTimeUtils();
  HandleInput handleInput = HandleInput();
  bool isVisibleTime = false;

  @override
  void initState() {
    dateContainerVisible();
    super.initState();
  }

  //To show/hide the container the clears the _dateContainer
  void dateContainerVisible() {
    _dateController.addListener(() {
      setState(() {
        isVisibleTime = _dateController.text.isNotEmpty;
      });
    });
  }

  String text = 'Please enter a task.';
  bool errorMessage = false;

  // void handleUpdateInput() {
  //   if (_titleController.text.isEmpty) {
  //     setState(() {
  //       errorMessage = true;
  //     });
  //   } else {
  //     firebaseService.updateData(
  //       widget.currentTask.title,
  //       widget.docID!,
  //     );
  //     Navigator.pop(context);
  //   }
  // }

  Future<void> selectedDate() async {
    DateTime? pickedDate = await dateUtils.getDate(
      context: context,
      firstDate: DateTime(2021),
      lastDate: DateTime(2060),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat.yMMMd().format(pickedDate);
      });
    }
  }

  Future<void> selectedTime() async {
    TimeOfDay? pickedTime = await timeUtils.getTime(
      context: context,
      textEditingController: _timeController,
    );
    if (pickedTime != null) {
      setState(() {
        _timeController.text = pickedTime.format(context);
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _dateController.removeListener(() {
      dateContainerVisible();
    });
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
            Row(
              children: [
                Expanded(
                  child: TextInputEntry(
                    controller: _titleController,
                    hintText: kAddTaskName,
                    maxLines: null,
                    readOnly: false,
                    keyboardType: TextInputType.multiline,
                    onChanged: (value) {
                      setState(() {
                        widget.currentTask.title = value;
                        // widget.currentTask.date = DateTime.parse(value);
                        // widget.currentTask.time = DateTime.parse(value);
                        widget.currentTask.docId;
                        errorMessage = false;
                      });
                    },
                  ),
                ),
                buildSizeBox(0, 10),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.blackColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 65,
                  width: 60,
                  child: Icon(
                    Icons.mic,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
            errorMessage
                ? Text(
                    text,
                    style: AppStyle.kErrorMessage,
                  )
                : const SizedBox(),
            buildSizeBox(20, 0),
            Text('Date'),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      selectedDate();
                    },
                    child: AbsorbPointer(
                      child: TextInputEntry(
                        readOnly: true,
                        hintText: 'Select Date',
                        maxLines: 1,
                        suffixIcon: Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                        ),
                        controller: _dateController,
                      ),
                    ),
                  ),
                ),
                buildSizeBox(0, 10),
                Visibility(
                  visible: isVisibleTime,
                  child: ResetContainer(
                    onTap: () {
                      _dateController.clear();
                      _timeController.clear();
                    },
                  ),
                )
              ],
            ),
            buildSizeBox(20, 0),
            Visibility(
              visible: isVisibleTime,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Time'),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // _selectedTime(context);
                            // getTime(context: context);
                            selectedTime();
                          },
                          child: AbsorbPointer(
                            child: TextInputEntry(
                              hintText: 'Select time',
                              readOnly: true,
                              maxLines: 1,
                              suffixIcon: Icon(
                                Icons.access_time,
                                color: Colors.grey,
                              ),
                              controller: _timeController,
                            ),
                          ),
                        ),
                      ),
                      buildSizeBox(0, 10),
                      ResetContainer(
                        onTap: () {
                          _timeController.clear();
                        },
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: AddTaskButton(
        color: AppColors.whiteColor,
        buttonColor: AppColors.mainColor,
        onTap: () {
          if (widget.docID == null) {
            handleInput.handleTitleInput(context, _titleController,
                _dateController, _timeController, widget.currentTask.title, () {
              setState(() {
                errorMessage = true;
              });
            });
          } else {
            handleInput.handleUpdateInput(
              context,
              _titleController,
              widget.currentTask.title,
              widget.docID,
              () {
                setState(() {
                  errorMessage = true;
                });
              },
            );
          }

          _titleController.clear();
        },
        text: kSaveTask,
      ),
    );
  }
}
