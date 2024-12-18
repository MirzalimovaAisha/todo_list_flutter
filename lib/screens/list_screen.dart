import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'dart:async';
import 'package:todo_list/providers/todo_default.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  late List<Todo> todos;
  TodoDefault todoDefault = TodoDefault();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 0), (){
      todos = todoDefault.getTodos();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('할 일 목록 앱'),
        centerTitle: true,
        backgroundColor: Colors.cyan,

        actions: [
          InkWell(
            onTap: (){},
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book),
                  Text('뉴스')
                ],
              ),
            ),
          )
        ],
      ),

      body: isLoading
          ? Center(
            child: CircularProgressIndicator(),
          )
          : ListView.separated(
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(todos[index].title),
                onTap: (){

                },
                trailing: Container(
                  width: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: InkWell(
                          child: Icon(Icons.edit),
                          onTap: (){},
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: InkWell(
                          onTap: () {},
                          child: Icon(Icons.delete),
                        ),
                      )
                    ],
                  ),
                ),
              );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Text('+', style: TextStyle(fontSize: 25),),
        onPressed: () {
          showDialog(
             context: context,
              builder: (BuildContext context){
               String title = '';
               String description = '';
               return AlertDialog(
                 title: const Text('할 일 추가하기'),
                 content: Container(
                   height: 200,
                   child: Column(
                     children: [
                       TextField(
                         onChanged: (value){
                           title = value;
                         },
                         decoration: const InputDecoration(
                             labelText: '제목'
                         ),
                       ),
                       TextField(
                         onChanged: (value){
                           description = value;
                         },
                         decoration: const InputDecoration(
                             labelText: '설명'
                         ),
                       ),
                     ],
                   ),
                 ),
                 actions: [
                   TextButton(
                       child: const Text('추가'),
                       onPressed: (){
                         setState(() {
                           print("[UI] ADD");
                           todoDefault.addTodo(
                             Todo(title: title, description: description)
                           );
                         });
                         Navigator.of(context).pop();
                       },
                   ),
                   TextButton(
                       child: const Text('추가'),
                       onPressed: (){
                         Navigator.of(context).pop();
                       },
                   ),
                 ],
               );
              }
          );
        },
      ),
    );
  }
}
























