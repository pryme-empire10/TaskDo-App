import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseService {
//GET collection
  CollectionReference db = FirebaseFirestore.instance.collection('users');

//CREATE
  Future<void> sendData(String title, DateTime? date, TimeOfDay? time) async {
    int? selectedDate;
    int? selectedTime;
    if (date != null) {
      selectedDate = date.millisecondsSinceEpoch;
    }
    if (time != null) {
      selectedTime = time.hour * 60 + time.minute;
    }
    await db.add(
      {
        "task name": title,
        'date': selectedDate,
        'time': selectedTime,
      },
    );
  }

  //READ
  Stream<QuerySnapshot> getData() {
    final titleStream = db.orderBy('date', descending: false).snapshots();
    return titleStream;
  }

  //UPDATE
  Future<void> updateData(String title, String docID) {
    return db.doc(docID).update({
      'task name': title,
    });
  }

  //DELETE
  Future<void> deletetasks(String docID) {
    return db.doc(docID).delete();
  }
}
