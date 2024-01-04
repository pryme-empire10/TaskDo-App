import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import 'package:provider/provider.dart';
import 'package:taskdo/widget/task_container_one.dart';

import '../consts/colors.dart';
import '../consts/text_string.dart';

import '../model/todo_model.dart';
import '../provider/todo_provider.dart';
import '../services/firebase_service.dart';
import '../widget/add_task_button.dart';
import '../widget/placeholder_task_container.dart';
import '../widget/task_container_two.dart';
import '../widget/text_input_entry.dart';
import 'tasks_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DateTime now = DateTime.now();

  final formatter = DateFormat('d MMMM');

  FirebaseService firebaseService = FirebaseService();

  TextEditingController _controller = TextEditingController();
  String searchQuery = '';

  // bool isFalsed = false;

  // void toggleIt() {
  //   setState(() {
  //     isFalsed = !isFalsed;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //  searchMe(searchTask);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 5.0,
        title: Text('All List'),
        backgroundColor: AppColors.mainColor,
        bottom: PreferredSize(
          preferredSize: Size(0, 100),
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
            child: TextInputEntry(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              onFieldSubmitted: (value) {
                setState(() {
                  _controller.clear();
                });
              },
              readOnly: false,
              hintText: 'Search',
              maxLines: 1,
              controller: _controller,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: firebaseService.getData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.hasData) {
                  final document = snapshot.data!.docs;

                  final filteredDocuments = document.where((doc) {
                    final taskName = doc['task name'].toString().toLowerCase();
                    final searchQuery = _controller.text.toLowerCase();
                    return taskName.contains(searchQuery);
                  }).toList();
                  if (document.isEmpty) {
                    return PlaceholderTaskContainer();
                  }
                  return Expanded(
                    child: filteredDocuments.isEmpty
                        ? Container(
                            height: 100,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(top: 50),
                            child: Text('Task not found'),
                          )
                        : ListView.builder(
                            itemCount: filteredDocuments.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot document =
                                  filteredDocuments[index];
                              final taskName = document['task name'];
                              final int? docDate = document['date'];
                              final int? docTime = document['time'];
                              final docId = document.id;

                              if (docDate != null) {
                                DateTime dateTime =
                                    DateTime.fromMillisecondsSinceEpoch(
                                        docDate);

                                TimeOfDay? ConvertToTimeOfDay(
                                    int? convertToTime) {
                                  if (convertToTime != null) {
                                    int hours = convertToTime ~/ 60;
                                    int minutes = convertToTime % 60;
                                    return TimeOfDay(
                                        hour: hours, minute: minutes);
                                  } else {
                                    return null;
                                  }
                                }

                                TimeOfDay? timeConverted =
                                    ConvertToTimeOfDay(docTime);
                                TodoModel task = TodoModel(
                                    title: taskName,
                                    date: dateTime,
                                    time: timeConverted);
                                return TaskContainerOne(
                                  tasks: task,
                                  docID: docId,
                                );
                              }
                              return TaskContainerTwo(
                                docID: docId,
                                tasks: TodoModel(
                                  title: taskName,
                                  date: DateTime.now(),
                                ),
                              );
                            },
                          ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: AddTaskButton(
        color: AppColors.whiteColor,
        buttonColor: AppColors.mainColor,
        text: kAddNewTask,
        onTap: () {
          TodoModel newTask = TodoModel(
            title: '',
            date: DateTime.now(),
          );
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 400),
              reverseDuration: const Duration(milliseconds: 400),
              child: TaskScreen(
                currentTask: newTask,
                todoProvider: Provider.of<TodoProvider>(context, listen: false),
              ),
              ctx: context,
            ),
          );
        },
      ),
    );
  }
}



// class ListTileContainer extends StatelessWidget {
//   const ListTileContainer({
//     super.key,
//     required this.task,
//     required this.todo,
//   });

//   final TodoModel task;
//   final TodoProvider todo;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Checkbox(
//         value: task.isChecked,
//         onChanged: (value) {
//           todo.toggleCheckedBox(task);
//           print('Check working');
//         },
//       ),
//       title: Text(task.title),
//       subtitle: Text(
//         DateFormat.yMMMEd().format(task.date),
//       ),
//     );
//   }
// }
