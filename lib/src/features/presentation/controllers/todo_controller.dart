import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/src/features/data/repository/todo_repository.dart';
import 'package:todo_app/src/features/domain/models/todo.dart';
import 'package:todo_app/src/utils/request_handlers.dart';
import 'package:todo_app/src/utils/todo_usecase.dart';

class TodoController {
  final TodoRepository _repository;

  TodoController(this._repository);

  Stream<List<Todo>> get todosStream => _repository.getTodos();

  Future<void> handleAddOrEdit({
    required TodoUseCase? useCase,
    required Todo todo,
    required RequestHandlers handlers,
  }) async {
    try {
      if (todo.title?.isNotEmpty ?? false) {
        handlers.onLoading?.call();
        if (useCase == TodoUseCase.addTodo) {
          await _repository.addTodo(todo);
        } else if (useCase == TodoUseCase.editTodo) {
          await _repository.updateTodo(todo);
        }
        handlers.onSuccess?.call();
      }
    } on FirebaseException catch (e) {
      handlers.onError?.call(e.message);
    } catch (e) {
      handlers.onError?.call(null);
    }
  }

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
