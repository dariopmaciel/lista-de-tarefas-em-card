import 'package:flutter/material.dart';
import 'package:listadetarefas/models/todo.dart';
import 'package:listadetarefas/widgets/todo_list_Item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> todos =
      []; //lista guardadas (data e horario) //todos é a lista toda
  Todo? deletedTodo;
  int? deletedTodoPosition;

  final TextEditingController todoControler = TextEditingController();
  //criação de controlador para pegar texto de um campo
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller:
                          todoControler, //acrescimo do controlador de captura de texto
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Add Tarefa:",
                        hintText: "Ex. Estudar Flutter",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String text = todoControler.text;
                      if (text.isEmpty) return;
                      setState(() {
                        Todo newTodo = Todo(
                          //criação do objeto newTodo para ser acrescentada a informação
                          title: text, //add o texto
                          dateTime: DateTime.now(), //add a hora
                        );
                        todos.add(newTodo); //add adicionado o todo na lista
                      });
                      todoControler
                          .clear(); //apaga a informação anterior do campo textfield
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff00d7f3),
                      padding: const EdgeInsets.all(14),
                    ),
                    child: Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (Todo todo in todos)
                      TodoListItem(
                        todo: todo,
                        onDelete: onDelete,
                      ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child:
                        Text("Voce possui ${todos.length} Tarefas pendentes"),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      //do the thing
                      showDeletedTodosConfirmationDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff00d7f3),
                      padding: EdgeInsets.all(14),
                    ),
                    child: Text("Limpar Tudo"),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  void onDelete(Todo todo) {
    deletedTodo = todo;
    deletedTodoPosition = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Tarefa ${todo.title} foi removida com sucesso!",
          style: const TextStyle(color: Colors.purple),
        ),
        backgroundColor: Colors.grey[300],
        action: SnackBarAction(
          label: "IH Errei, volta aê",
          textColor: Colors.purple[700],
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoPosition!, deletedTodo!); //do the thing
            });
          },
        ),
        duration: const Duration(seconds: 5), //tempo de duração do snackbar
      ),
    );
  }

  void showDeletedTodosConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Limpar TUDO?"),
        content:
            const Text("Você tem CERTEZA que deseja apagar TODAS as Tarefas?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(primary: const Color(0xff00d7f3)),
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              //do the thing
              deleteAllTodos();
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(primary: Colors.red[700]),
            child: const Text("Limpar Tudo"),
          ),
        ],
      ),
    );
  }

  void deleteAllTodos() {
    setState(() {
      todos.clear();
    });
  }
}
