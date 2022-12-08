import 'dart:convert';

import 'package:listadetarefas/models/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

//criação de constante para
const todoListKey = 'todo_list';

class TodoRepository {
//construtor
//este construtor foi substituido pelo getTodoList
  /*TodoRepository() {
    SharedPreferences.getInstance().then((value) {
      sharedPreferences = value;
      //printar no console
      print(sharedPreferences.getString('todo_list'));
    });
  }*/

  late SharedPreferences sharedPreferences;

  Future<List<Todo>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    //'[]' é um json que simboliza uma lista vazia
    final String jsonString = sharedPreferences.getString(todoListKey) ?? '[]';
    //retorno de um mapa ou uma lista
    final List jsonDecode = json.decode(jsonString) as List;
    //comando '.map' pega cada item da lista e converte para um objeto do tipo todo
    //para isto acontecer é preciso receber este dado e transformar em um objeto todo de todo.dart
    return jsonDecode.map((e) => Todo.fromJson(e)).toList();
  }

/*
  void exemplo() {
    //armazenagem
    //devido oa 'SharedPreferences', pode-se armazenar apenas dados simples. (set com poucas variaçãoes. Do tipo primitivo)
    sharedPreferences.setString("nome", "Dario");
    //retorno
    sharedPreferences.getString("nome");
  }*/

  //Para armazenas um OBJETO do tipo tarefa 'todo.dart' não é um objeto primitivo é um objeto customizado, usa-se o padrão JSON.

  //sarva a lista
  //este saveTodoList vai receber uma lista de todos
  //devido a este import de 'Todo' o codigo sabe converter para json
  void saveTodoList(List<Todo> todos) {
    //isto transforma a lista de tarefa em um texto, codigicado no padrão json
    final jsonString = json.encode(todos);
    //imprime o jsonstring no console para visualizar
    print(jsonString);
    //armazenagem no 'SharedPreferences'
    sharedPreferences.setString('todo_list', jsonString);
  }
}
