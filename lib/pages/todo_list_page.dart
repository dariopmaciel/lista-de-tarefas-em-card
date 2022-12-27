import 'package:flutter/material.dart';
import 'package:listadetarefas/models/todo.dart';
import 'package:listadetarefas/repository/todo_repository.dart';
import 'package:listadetarefas/widgets/todo_list_Item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  //criação de controlador para pegar texto de um campo
  final TextEditingController todoControler = TextEditingController();
  //instanciação para ter acesso ao 'todo_repository.dart'
  final TodoRepository todoRepository = TodoRepository();

  //lista guardadas (data e horario) //todos é a lista toda
  List<Todo> todos = [];

  Todo? deletedTodo;
  int? deletedTodoPosition;
  String? errorText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    todoRepository.getTodoList().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("App Multiuso"),
          ),
          drawer: Drawer(
            child: ListView(
              children: const [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    "Dario",
                  ),
                  accountEmail: Text(
                    "dariodepaulamaciel@hotmail.com",
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                    child: Text(
                      "D",
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                      "Este projeto foi criado como um experimento de aprendizado."),
                ),
                ListTile(
                  title: Text("Obrigado por sua visualização."),
                ),
              ],
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        //'Expanded' expande até a máxima largura possivel
                        child: TextField(
                          controller:
                              todoControler, //acrescimo do controlador de captura de texto
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: "Add Tarefa:",
                            hintText: "Ex. Estudar Flutter",
                            errorText: errorText,
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff00d7f3),
                                width: 3,
                              ),
                            ),
                            labelStyle:
                                const TextStyle(color: Color(0xff00d7f3)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          //aqui será invertido, eu acho
                          String text = todoControler.text;
                          if (text.isEmpty) {
                            setState(() {
                              errorText = "* Campo obrigatório!";
                            });
                            return;
                          }
                          ;

                          setState(() {
                            Todo newTodo = Todo(
                              //criação do objeto newTodo para ser acrescentada a informação
                              title: text, //add o texto
                              dateTime: DateTime.now(), //add a hora
                            );
                            todos.add(newTodo); //add adicionado o todo na lista
                            errorText = null;
                          });
                          //apaga a informação anterior do campo textfield
                          todoControler.clear();
                          todoRepository.saveTodoList(todos);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xff00d7f3), //cor em hexadecimal
                          padding: const EdgeInsets.all(
                              14), //expaçamento entre txt e borda do btn
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                      height: 16), //expaçamento entre textfield e item
                  Flexible(
                    child: ListView(
                      shrinkWrap: true, //deixa a lista o mais enchuta possivel
                      children: [
                        for (Todo todo in todos)
                          TodoListItem(
                            todo: todo,
                            onDelete: onDelete,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                      height: 16), //expaçamento entre textfield e item
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            "Voce possui: ${todos.length} tarefas pendentes"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          //do the thing
                          showDeletedTodosConfirmationDialog();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff00d7f3),
                          padding: const EdgeInsets.all(14),
                        ),
                        child: const Text("Limpar Tudo"),
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
    todoRepository.saveTodoList(todos);

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Tarefa ${todo.title} foi removida com sucesso!",
          style: const TextStyle(color: Colors.purple),
        ),
        backgroundColor: Colors.grey[300],
        action: SnackBarAction(
          label: "Deseja desfazer?",
          textColor: Colors.purple[700],
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoPosition!, deletedTodo!); //do the thing
            });
            todoRepository.saveTodoList(todos);
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
            child: const Text("Cancelar"),
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
    todoRepository.saveTodoList(todos);
  }
}
