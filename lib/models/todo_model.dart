// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? docId;
  final String titleTask;
  final String description;
  final String dateTask;
  final String timeTask;
  final String category;
  final bool isDone;

  TodoModel(
      {required this.isDone,
      this.docId,
      required this.titleTask,
      required this.description,
      required this.dateTask,
      required this.timeTask,
      required this.category});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docId': docId,
      'titleTask': titleTask,
      'description': description,
      'dateTask': dateTask,
      'timeTask': timeTask,
      'category': category,
      'isDone': isDone,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      docId: map['docId'] != null ? map['docId'] as String : null,
      titleTask: map['titleTask'] as String,
      description: map['description'] as String,
      dateTask: map['dateTask'] as String,
      timeTask: map['timeTask'] as String,
      category: map['category'] as String,
      isDone: map['isDone'] as bool,
    );
  }
  factory TodoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TodoModel(
        docId: doc.id,
        category: doc['category'],
        titleTask: doc['titleTask'],
        description: doc['description'],
        dateTask: doc['dateTask'],
        timeTask: doc['timeTask'],
        isDone: doc['isDone']);
  }
}
