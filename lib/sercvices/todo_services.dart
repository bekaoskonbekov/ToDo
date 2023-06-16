import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/todo_model.dart';

class TodoService {
  final todoCollection = FirebaseFirestore.instance.collection('todoApp');

  //create

  void addNewTask(TodoModel todoModel) {
    todoCollection.add(todoModel.toMap());
  }

  void updateTask(String? docId, bool? valueUpdate) {
    todoCollection.doc(docId).update({'isDone': valueUpdate});
  }

  void deleteTask(
    String? docId,
  ) {
    todoCollection.doc(docId).delete();
  }
}
