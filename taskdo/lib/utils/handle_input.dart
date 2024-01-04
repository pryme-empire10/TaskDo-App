import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/firebase_service.dart';

class HandleInput {
  FirebaseService firebaseService = FirebaseService();
  void handleTitleInput(
    BuildContext context,
    TextEditingController titleController,
    TextEditingController dateController,
    TextEditingController timeController,
    String title,
    Function callBack,
  ) {
    if (titleController.text.isEmpty) {
      callBack();
    } else {
      firebaseService.sendData(
        title,
        dateController.text.isEmpty
            ? null
            : DateFormat.yMMMd().parse(dateController.text),
        timeController.text.isEmpty
            ? null
            : TimeOfDay.fromDateTime(
                DateFormat.Hm().parse(timeController.text),
              ),
      );

      Navigator.pop(context);
    }
  }

  void handleUpdateInput(
      BuildContext context,
      TextEditingController titleController,
      String title,
      String? docID,
      Function callBack) {
    if (titleController.text.isEmpty) {
      callBack();
    } else {
      firebaseService.updateData(
        title,
        docID!,
      );
      Navigator.pop(context);
    }
  }
}
