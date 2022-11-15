import 'package:flutter/material.dart';
import 'package:listadetarefas/widgets/todo_list_Item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<String> todos = [];
  // to dos // tarefas // afazeres
  final TextEditingController todoControler = TextEditingController();
  //criação de controlador para pegar texto de um campo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller:
                        todoControler, //acrescimo do controlador de captura de texto
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Add Tarefa:",
                      hintText: "Ex. Estudar Flutter",
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    String text = todoControler.text;
                    setState(() {
                      todos.add(text); //add
                      todoControler.clear(); //apaga
                    });
                    //adicionado oque esta no campo dentro da lista de todos
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff00d7f3),
                    padding: EdgeInsets.all(14),
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
                  for (String todo in todos) TodoListItem(),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text("Voce possui 0 Tarefas pendentes"),
                ),
                SizedBox(
                  width: 8,
                ),
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
    ));
  }
}
