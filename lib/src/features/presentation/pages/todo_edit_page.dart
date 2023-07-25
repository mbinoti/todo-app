import 'package:flutter/material.dart';
import 'package:todo_app/src/features/domain/models/todo.dart';
import 'package:todo_app/src/features/presentation/controllers/todo_controller.dart';
import 'package:todo_app/src/features/presentation/widgets/custom_date_picker.dart';
import 'package:todo_app/src/features/presentation/widgets/custom_text.dart';
import 'package:todo_app/src/features/presentation/widgets/primary_button.dart';
import 'package:todo_app/src/features/presentation/widgets/task_textfield.dart';
import 'package:todo_app/src/theme/app_theme.dart';
import 'package:todo_app/src/utils/conversion.dart';
import 'package:todo_app/src/utils/helpers.dart';
import 'package:todo_app/src/utils/request_handlers.dart';

class TodoEditPage extends StatefulWidget {
  // final TodoRouteProps routeProps;
  final TodoController todoController;
  final Todo? todo;

  const TodoEditPage({
    Key? key,
    this.todo,
    // required this.routeProps,
    required this.todoController,
  }) : super(key: key);

  @override
  State<TodoEditPage> createState() => _TodoEditPageState();
}

class _TodoEditPageState extends State<TodoEditPage> {
  ValueNotifier<DateTime?> dateTime = ValueNotifier<DateTime?>(null);

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.todo?.title ?? "";
    descriptionController.text = widget.todo?.description ?? "";
    dateTime.value = widget.todo?.dateTime;
  }

  void saveButtonHandler() {
    final Todo todo = Todo(
      id: widget.todo?.id, // Este campo pode ser nulo para um novo Todo
      dateTime: dateTime.value,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
    );

    if (todo.id != null) {
      // Editando um Todo existente
      widget.todoController
          .EditTodo(
              todo: todo,
              handlers: RequestHandlers(
                onError: ([message]) =>
                    Helpers.onErrorSnackbar(message, context),
                onSuccess: () => Helpers.onSuccessSnackbar(context),
                onLoading: () => Helpers.onLoadingSnackbar(context),
              ))
          .then((_) {
        Navigator.pop(context);
      });
    } else {
      // Adicionando um novo Todo
      widget.todoController
          .AddTodo(
              todo: todo,
              handlers: RequestHandlers(
                onError: ([message]) =>
                    Helpers.onErrorSnackbar(message, context),
                onSuccess: () => Helpers.onSuccessSnackbar(context),
                onLoading: () => Helpers.onLoadingSnackbar(context),
              ))
          .then((_) {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            value: widget.todo == null ? "adicionar tarefa" : "editar tarefa",
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: AppTheme.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              children: [
                TaskTextField(
                    controller: titleController, hintText: "digite um nome.."),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: TaskTextField(
                        controller: descriptionController,
                        maxLines: 6,
                        hintText: "digite a descrição..")),
                ListTile(
                    leading: const Icon(Icons.date_range),
                    title: const CustomText(
                      value: "Quando você deseja executar esta tarefa?",
                    ),
                    subtitle: ValueListenableBuilder<DateTime?>(
                      valueListenable: dateTime,
                      builder: (context, value, _) {
                        return CustomText(
                            value: Conversion.formatDate(dateTime.value));
                      },
                    ),
                    trailing: CustomDatePicker(
                      initialDate: widget.todo?.dateTime,
                      onDateSelected: (value) {
                        dateTime.value = value;
                      },
                    )),
                const SizedBox(height: 30),
                PrimaryButton(
                  labelText: "gravar",
                  onPressed: saveButtonHandler,
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
