import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/providers/todo_dummy.dart';
import 'package:todo_app/screens/todo_create_screen.dart';
import 'package:todo_app/screens/todo_detail_screen.dart';

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
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            // leading: Text(todo.id.toString()),
            leading: Image.asset(
              'assets/images/todo/interface-and-abstract-class.png',
              width: 40,
              height: 40,
            ),
            title: Text(todo.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TodoDetailScreen(),
                ),
              );
            },
            // 수정•삭제
            trailing: Container(
              width: 50,
              child: Row(
                children: [
                  Container(
                    child: InkWell(child: Icon(Icons.edit), onTap: () {}),
                  ),
                  Container(
                    child: InkWell(
                      child: Icon(Icons.delete),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Todo'),
                              content: Container(child: Text('삭제하시겠습니까?')),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      todoDummy.deleteTodo(
                                        todos[index].id ?? 0,
                                      );
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('삭제하기'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('취소하기'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TodoCreateScreen()),
          );
        },
        child: Text('+'),
      ),
    );
  }
}
