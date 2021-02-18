import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'models/task.dart';

class DetailTaskScreen extends StatefulWidget {
  final int id;

  DetailTaskScreen({this.id}) : super();

  @override
  _DetailTaskScreenState createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail task"),
      ),
      body: FutureBuilder(
        future: fetchTaskById(http.Client(), widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData) {
            return DetailTask(task: snapshot.data);

            ///
            ///
            /// 34:53 / 53:13
            /// Idk wtf but i cant coding, i sleep
            ///
            ///
            ///
            ///
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
