import 'package:final_640710147/models/todo_item.dart';
import 'package:flutter/material.dart';
import '../helpers/api_caller.dart';
import '../helpers/dialog_utils.dart';
import 'dart:convert';

class Todo_pages extends StatefulWidget {
  final TodoItem todoItem; // เพิ่มตัวแปร todoItem เพื่อรับข้อมูล TodoItem

  const Todo_pages({Key? key, required this.todoItem}) : super(key: key);

  @override
  State<Todo_pages> createState() => _Todo_pages();
}

class _Todo_pages extends State<Todo_pages> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _showTodoDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Pages'),
      ),
      body: Center(
        // No need for a button here since dialog will be shown automatically
      ),
    );
  }

  void _showTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildParameterRow(String key, String description, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$key:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
