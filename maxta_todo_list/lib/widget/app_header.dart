
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../consts/text_style.dart';
import '../provider/todo_provider.dart';
import 'task_button.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.formatter,
    required this.now,
    required this.currentTask,
  });

  final DateFormat formatter;
  final DateTime now;
  final TodoProvider currentTask;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formatter.format(now),
                style: AppStyle.kDateStyle,
              ),
              Text(
                'Today',
                style: AppStyle.kTodayStyle,
              )
            ],
          ),
          TaskButton(
            currentTask: currentTask,
          )
        ],
      ),
    );
  }
}
