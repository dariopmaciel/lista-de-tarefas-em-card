//criação de classe para guardar data e horário

//Json nada mais é doque armazenar da dados em formato de mapa

class Todo {
  Todo({required this.title, required this.dateTime});

  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        dateTime = DateTime.parse(json["datetime"]);

  String title;
  DateTime dateTime;

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "datetime": dateTime.toIso8601String(),
    };
  }
}
