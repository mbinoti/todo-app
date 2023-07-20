import 'package:flutter/material.dart';
import 'package:todo_app/src/extensions/firebase_extension.dart';
import 'package:todo_app/src/features/data/repository/todo_repository.dart';
import 'package:todo_app/src/features/presentation/controllers/todo_controller.dart';
import 'package:todo_app/src/features/presentation/pages/todo_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseExtension.initializeAndConfigure();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({Key? key}) : super(key: key);

  // Cria uma instância de TodoRepository
  final todoRepository = TodoRepository();

  @override
  Widget build(BuildContext context) {
    // Cria uma instância de TodoController
    final todoController = TodoController(todoRepository);

    return MaterialApp(
      home: Scaffold(
        body: TodoPage(todoController: todoController),
      ),
    );
  }
}
