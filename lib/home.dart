import 'package:flutter/material.dart';
import 'package:re_todo/to-do.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TODO> todos = <TODO>[
    // Creates growable list.
    TODO("Test 1 TODO"), // this.title
    TODO("Test 2 TODO"),
    TODO("Test 3 TODO"),
  ];
  @override
  Widget build(BuildContext context) {
    final TextEditingController todoController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("TODO APP"),
        ),
      ),
      body: ListView.builder(
        /* It is used to create the list of children But when we want to create a list recursively
                                 without writing code again and again then ListView.builder is used instead of ListView.
                                 ListView.builder creates a scrollable, linear array of widgets.*/
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(todos[index].title),
              /*The itemCount parameter decides how many times the callback
                                     function in itemBuilder will be called. In here, the in-place callback function shall be called 4 times and
                                      each call will generate a Text Widget which shall be displayed in the body.*/
              trailing: IconButton(
                onPressed: () {
                  if (todos.length > 3) {
                    setState(() {
                      todos.removeAt(index);
                    });
                  }
                },
                icon: const Icon(Icons.delete),
                color: Colors.red,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              /*A modal bottom sheet is an alternative to a menu or
        a dialog and prevents the user from interacting with the rest of the app. A closely related widget*/
              builder: (context) {
                return Container(
                  height: 250,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Add TO DO",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Enter TODO name",
                        ),
                        controller: todoController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              todos.add(
                                TODO(todoController.text),
                              );
                              todoController.clear();
                              Navigator.pop(context);
                            });
                          },
                          child: const Text("Submit"))
                    ],
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
