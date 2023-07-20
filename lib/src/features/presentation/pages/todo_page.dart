import 'package:flutter/material.dart';
import 'package:todo_app/src/features/domain/models/todo.dart';
import 'package:todo_app/src/features/presentation/controllers/todo_controller.dart';

class TodoPage extends StatelessWidget {
  final TodoController todoController;

  TodoPage({required this.todoController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('todo app'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Adicione aqui a lógica para adicionar um novo Todo
              todoController.addTodo(
                title: 'New Todo',
                description: 'This is a new todo.',
                dateTime: DateTime.now(),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Todo>>(
        stream: todoController.todosStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(strokeWidth: 1.5));
          } else if (snapshot.hasError) {
            return const Center(child: Text('Algo deu errado.'));
          } else {
            final todos = snapshot.data ?? [];
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  title: Text(todo.title!),
                  subtitle: Text(todo.description!),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Adicione aqui a lógica para adicionar um novo Todo
          todoController.addTodo(
            title: 'New Todo',
            description: 'This is a new todo.',
            dateTime: DateTime.now(),
          );
        },
      ),
    );
  }
}
