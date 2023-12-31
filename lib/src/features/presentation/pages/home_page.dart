import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatar a data

import 'package:todo_app/src/features/domain/models/todo.dart';
import 'package:todo_app/src/features/presentation/controllers/todo_controller.dart';
import 'package:todo_app/src/features/presentation/pages/todo_edit_page.dart';
import 'package:todo_app/src/theme/app_theme.dart';

class HomePage extends StatelessWidget {
  final TodoController todoController;

  HomePage({required this.todoController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Todo App')),
        body: StreamBuilder<List<Todo>>(
          stream: todoController.todosStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: TaskTile(
                      todo: snapshot.data![index],
                      todoController: todoController,
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => TodoEditPage(
                  todo: null,
                  todoController: todoController,
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ));
  }
}

class TaskTile extends StatelessWidget {
  final Todo? todo;
  final TodoController todoController;

  const TaskTile({
    Key? key,
    required this.todo,
    required this.todoController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.randomColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(1),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => TodoEditPage(
                todo: todo,
                todoController: todoController,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
                  child: Text(
                    todo?.title ?? "",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => todoController.deleteTodo(todo!.id!),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 5, right: 10),
                child: Text(
                  todo?.description ?? "",
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5, bottom: 3.0),
              child: Text(
                DateFormat('dd/MM/yyyy HH:mm')
                    .format(todo?.dateTime ?? DateTime.now()),
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
