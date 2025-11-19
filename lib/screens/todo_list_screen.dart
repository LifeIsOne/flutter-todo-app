import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todo_dummy.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todos = [];
  TodoDummy todoDummy = TodoDummy();

  @override
  void initState() {
    super.initState();
    todos = todoDummy.getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        // actions: [
        //   InkWell(
        //     onTap: () {},
        //     child: Container(
        //       padding: EdgeInsets.all(5),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [Icon(Icons.note), Text('미라클 코딩')],
        //       ),
        //     ),
        //   ),
        // ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('+'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            leading: Text(todo.id.toString()),
            title: Text(todo.title),
          );
        },
      ),
    );
  }
}
