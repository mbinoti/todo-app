import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/src/features/domain/models/todo.dart';

class TodoRepository {
  final _todosCollection = FirebaseFirestore.instance.collection('todos');

  @override
  Stream<List<Todo>> getTodos() {
    return _todosCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Todo(
          id: doc.id,
          title: doc.get('title'),
          description: doc.get('description'),
          dateTime: (doc.get('dateTime') as Timestamp).toDate(),
        );
      }).toList();
    });
  }

  @override
  Future<void> addTodo(Todo todo) async {
    await _todosCollection.add({
      'title': todo.title,
      'description': todo.description,
      'dateTime': todo.dateTime,
    });
  }

  @override
  Future<void> deleteTodo(String id) async {
    await _todosCollection.doc(id).delete();
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    await _todosCollection.doc(todo.id).update({
      'title': todo.title,
      'description': todo.description,
      'dateTime': todo.dateTime,
    });
  }
}
