import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:resfulAPI/global.dart';

class Todo {
  int id;
  String name;
  String dueDate;
  String description;
  // Constructor
  Todo({this.id, this.name, this.dueDate, this.description});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      name: json['name'],
      dueDate: json['duedate'],
      description: json['description'],
    );
  }
}
//Fetch data from Resful API

Future<List<Todo>> fetchTodos(http.Client client) async {
  final response = await client.get(URL_TODOS);
  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    if (mapResponse["result"] == "ok") {
      final todos = mapResponse["data"].cast<Map<String, dynamic>>();
      final listOfTodos = await todos.map<Todo>((json) {
        return Todo.fromJson(json);
      }).toList();
      return listOfTodos;
    } else {
      return [];
    }
  } else {
    throw Exception("Failed to load Todo from the Internet");
  }
}
