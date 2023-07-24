import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/src/features/data/repository/todo_repository.dart';
import 'package:todo_app/src/features/domain/models/todo.dart';
import 'package:todo_app/src/utils/request_handlers.dart';
import 'package:todo_app/src/utils/todo_usecase.dart';

class TodoController {
  final TodoRepository _repository;

  TodoController(this._repository);

  Stream<List<Todo>> get todosStream => _repository.getTodos();

  Future<void> AddTodo(
      {required Todo todo, required RequestHandlers handlers}) async {
    try {
      handlers.onLoading!();
      await _repository.addTodo(todo);
      handlers.onSuccess!();
    } catch (e) {
      handlers.onError!(e.toString());
    }
  }

  Future<void> EditTodo(
      {required Todo todo, required RequestHandlers handlers}) async {
    try {
      handlers.onLoading!();
      await _repository.updateTodo(todo);
      handlers.onSuccess!();
    } catch (e) {
      handlers.onError!(e.toString());
    }
  }

  void deleteTodo(String id) {
    _repository.deleteTodo(id);
  }
}
