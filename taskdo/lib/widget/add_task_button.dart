import 'package:flutter/material.dart';
import 'package:taskdo/consts/colors.dart';

import '../consts/text_style.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton(
      {super.key,
      required this.onTap,
      required this.text,
      required this.color,
      required this.buttonColor});

  final VoidCallback onTap;
  final String text;
  final Color color;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(color: color, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          offset: const Offset(0, 2),
          spreadRadius: 5,
          blurRadius: 7,
        )
      ]),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: buttonColor,
          ),
          margin: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
          child: Center(
            child: Text(
              text,
              style: AppStyle.kAddTask,
            ),
          ),
        ),
      ),
    );
  }
}
