import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:listadetarefas/models/todo.dart';

class TodoListItem extends StatelessWidget {
  TodoListItem({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[500],
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(16),
      child: Slidable(
        startActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.archive,
              //label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context) {},
              backgroundColor: Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.share,
              //label: 'Share',
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              DateFormat("dd/MMM/yyyy - HH:mm").format(
                  todo.dateTime), //formatação de datatime com base no pubspec
              //todo.dateTime.toString(),
              style: TextStyle(fontSize: 19),
            ),
            Text(
              todo.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
