import 'package:flutter/material.dart';

import '../model/todo_model.dart';
import 'colors.dart';

class AppStyle {
  AppStyle._();
  static TextStyle kTaskHeader = const TextStyle(
    fontSize: 16,
    fontFamily: 'Poppins-Regular',
    fontWeight: FontWeight.w600,
  );

  static TextStyle kSaveTaskButton = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    fontFamily: 'Poppins-Regular',
    // color: AppColors.blackColor,
  );

  static TextStyle kTaskTitle(TodoModel task) {
    return TextStyle(
      color: task.isChangeContainerColor
          ? AppColors.blackColor
          : AppColors.whiteColor,
      fontSize: 18,
      fontFamily: 'Poppins-Regular',
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle kTaskSubtitle(TodoModel task) {
    return TextStyle(
      color: task.isChangeContainerColor
          ? AppColors.blackColor
          : AppColors.whiteColor,
      fontSize: 13,
      fontFamily: 'Poppins-Regular',
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle kDateStyle = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );

  static TextStyle kTodayStyle = const TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w500,
  );

  static TextStyle kAddTask = TextStyle(
    fontSize: 15,
    fontFamily: 'Poppins-Regular',
    color: AppColors.whiteColor,
  );

  static TextStyle kNothingToDo = TextStyle(
    fontFamily: 'Poppins-Regular',
    fontSize: 20,
    color: AppColors.blackColor.withOpacity(0.3),
  );

  static TextStyle kTextInputStyle = TextStyle(
    color: AppColors.blackColor,
    fontFamily: 'Poppins-Regular',
  );

  static TextStyle kHintStyle = TextStyle(
    color: AppColors.blackColor.withOpacity(0.3),
    fontFamily: 'Poppins-Regular',
  );
}
