
import 'package:flutter/material.dart';

class Task {
  final String name;
  final String description;

  Task(this.name, this.description);
}

class TaskDetailPage extends StatelessWidget {
  final Task task;

  TaskDetailPage({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          task.description,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
