import 'package:flutter/material.dart';
import 'package:todo_app/src/features/domain/models/todo.dart';
import 'package:todo_app/src/features/presentation/controllers/todo_controller.dart';

class TaskMenu extends StatelessWidget {
  final Todo? todo;
  final TodoController todoController; // Ou TodoRepository, se preferir

  TaskMenu({Key? key, required this.todo, required this.todoController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final todoController = TodoController();
    return PopupMenuButton<String>(
      elevation: 0.5,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Edit',
          child: Text("Edit"),
        ),
        const PopupMenuItem<String>(
          value: 'Delete',
          child: Text('Delete'),
        ),
      ],
      onSelected: (String value) {
        if (value == 'Edit') {
          // Aqui, você deve navegar para a tela de edição.
          // Não temos uma rota exata, então usarei um substituto.
          Navigator.pushNamed(context, '/editTodo', arguments: todo);
        } else if (value == 'Delete') {
          // Aqui, a tarefa é deletada usando o TodoController.
          todoController.deleteTodo(todo?.id ?? "");
          // Exiba um Snackbar para indicar o sucesso da operação.
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Task has successfully deleted!')));
        }
      },
      icon: const Icon(Icons.more_vert),
    );
  }
}
