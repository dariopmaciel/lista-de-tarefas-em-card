import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:listadetarefas/models/todo.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    Key? key,
    required this.todo,
    required this.onDelete,
  }) : super(key: key);

  final Todo todo;
  final Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 2), //add para inserir borda em todos os containes
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.5,
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                //do the thing
              },
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(15),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            SlidableAction(
              onPressed: (context) {
                //do the thing
              },
              icon: Icons.share,
              borderRadius: BorderRadius.circular(15),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                onDelete(todo);
              },
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(15),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              label: "Deletar",
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[00],
          ),
//        margin: const EdgeInsets.symmetric(vertical: 5), //removido pois só estava no container central
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                DateFormat("dd/MMM/yyyy - HH:mm").format(
                    todo.dateTime), //formatação de datatime com base no pubspec
                //todo.dateTime.toString(),
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                todo.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
