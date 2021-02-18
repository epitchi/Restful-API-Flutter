import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:resfulAPI/global.dart';

class Task {
  int id;
  String name;
  bool finished;
  int todoId;
  //Constructor
  Task({this.id, this.name, this.finished, this.todoId});
  //Do the same as Todo
  factory Task.fromJson(Map<String, dynamic> json) {
    Task newTask = Task(
      id: json['id'],
      name: json['name'],
      finished: json['isfinished'],
      todoId: json['todoid'],
    );
    //newTask.showDetails();
    return newTask;
  }
  //clone a Task, or "copy constructor"
  factory Task.fromTask(Task anotherTask) {
    return Task(
      id: anotherTask.id,
      name: anotherTask.name,
      finished: anotherTask.finished,
      todoId: anotherTask.todoId,
    );
  }
}

Future<List<Task>> fetchTasks(http.Client client, int todoId) async {
  final response = await client.get('$URL_TASKS_BY_TODOID$todoId');
  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    if (mapResponse["result"] == "ok") {
      final tasks = mapResponse["data"].cast<Map<String, dynamic>>();
      return tasks.map<Task>((json) {
        return Task.fromJson(json);
      }).toList();
    } else {
      throw Exception('Failed to load Task');
    }
  }
}

// Fetch Task by id
Future<List<Task>> fetchTaskById(http.Client client, int id) async {
  final response = await client.get('$URL_TASKS/$id');

  if (response.statusCode == 200) {
    Map<String, dynamic> mapResponse = json.decode(response.body);
    if (mapResponse["result"] == "ok") {
      final tasks = mapResponse["data"].cast<Map<String, dynamic>>();
      return tasks.map<Task>((json) {
        return Task.fromJson(json);
      }).toList();
    } else {
      throw Exception('Failed to get detail task with Id = {id}');
    }
  }
}

//Update a task
Future<Task> updateATask(
    http.Client client, Map<String, dynamic> params) async {
  final response = await client.put('$URL_TASKS/${params["id"]}', body: params);
  if (response.statusCode == 200) {
    final responseBody = await json.decode(response.body);
    return Task.fromJson(responseBody);
  } else {
    throw Exception('Failed to update a Task. Error: ${response.toString()}');
  }
}

//Delete a Task

Future<Task> deletaATask(http.Client client, int id) async {
  final String url = '$URL_TASKS/$id';
  final response = await client.delete(url);
  if (response.statusCode == 200) {
    final responseBody = await json.decode(response.body);
    return Task.fromJson(responseBody);
  } else {
    throw Exception('Failed to delete a Task');
  }
}
