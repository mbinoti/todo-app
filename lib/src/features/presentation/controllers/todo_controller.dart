import 'package:todo_app/src/features/data/repository/todo_repository.dart';
import 'package:todo_app/src/features/domain/models/todo.dart';

class TodoController {
  final TodoRepository _repository;

  TodoController(this._repository);

  Stream<List<Todo>> get todosStream => _repository.getTodos();

  void addTodo(
      {required String title,
      required String description,
      required DateTime dateTime}) {
    final todo = Todo(
      id: null,
      title: title,
      description: description,
      dateTime: dateTime,
    );
    _repository.addTodo(todo);
  }

  void deleteTodo(String id) {
    _repository.deleteTodo(id);
  }

  void updateTodo(
      {required String id,
      required String title,
      required String description,
      required DateTime dateTime}) {
    final todo = Todo(
      id: id,
      title: title,
      description: description,
      dateTime: dateTime,
    );
    _repository.updateTodo(todo);
  }
}
