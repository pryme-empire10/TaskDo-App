
import 'package:flutter/material.dart';


import '../consts/colors.dart';
import '../consts/text_style.dart';



class AddTaskButton extends StatelessWidget {
  const AddTaskButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(0, 2),
            spreadRadius: 5,
            blurRadius: 7)
      ]),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.mainColor,
          ),
          margin:
              const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
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
