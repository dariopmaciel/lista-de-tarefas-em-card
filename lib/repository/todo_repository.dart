import 'dart:convert';

import 'package:listadetarefas/models/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoRepository {
  TodoRepository() {
    SharedPreferences.getInstance().then((value) => sharedPreferences = value);
  }

  late SharedPreferences sharedPreferences;

  //função exemplo
  // void exemplo() {
  //   sharedPreferences.setString(
  //       "nome", "Dario"); //armazenando com a chave "nome" o item "Dario"
  //   sharedPreferences.getString("nome"); //buscando com a chave "nome"
  // }
  void saveTodoList(List<Todo> todos) {
    final jsonString = jsonEncode(todos);
    print(jsonString);
  }
}
