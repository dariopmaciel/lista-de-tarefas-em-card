import 'package:flutter/material.dart';
import 'package:listadetarefas/models/todo.dart';
import 'package:listadetarefas/widgets/todo_list_Item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> todos = []; //lista de classes guardadas (data e horario)

  final TextEditingController todoControler = TextEditingController();
  //criação de controlador para pegar texto de um campo
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                    child: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (Todo todo in todos)
                      TodoListItem(
                        todo: todo,
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
                    onPressed: () {},
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
}
