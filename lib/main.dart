import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final MaterialColor myCustomColor = MaterialColor(0xFF49439b, {
      50: Color(0xFF49439b),
      100: Color(0xFF49439b),
      200: Color(0xFF49439b),
      300: Color(0xFF49439b),
      400: Color(0xFF49439b),
      500: Color(0xFF49439b),
      600: Color(0xFF49439b),
      700: Color(0xFF49439b),
      800: Color(0xFF49439b),
      900: Color(0xFF49439b),
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: myCustomColor,
      ),
      home: ToDoList(),
    );
  }
}

final TextEditingController _controller = TextEditingController();

class Task {
  String task;
  bool ischecked;
  bool completedTask;
  Task(
      {required this.task, this.ischecked = false, this.completedTask = false});
}

class TaskList {
  List<Task> tasks = [];

  void add(Task task) {
    tasks.add(task);
  }

  void delete(Task task) {
    tasks.remove(task);
  }
}

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  int incompletedTasks = 0;
  int completedTasks = 0;
  final list = TaskList();
  final TextEditingController _controller = TextEditingController();
  late String formattedDate;
  late DateFormat formatter;
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    formatter = DateFormat('yyyy-MM-dd');
    formattedDate = formatter.format(now);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                  height: 150,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(211, 20, 20, 25),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                hintText: 'type here',
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontFamily: 'vari'),
                              ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                String fieldValue = _controller.text;
                                _controller.text = '';
                                Task newTask = Task(task: fieldValue);
                                Navigator.pop(context);
                                setState(() {
                                  incompletedTasks++;
                                  list.add(newTask);
                                });
                              },
                              child: Text('save here'),
                            ),
                          ],
                        ),
                      )));
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xff141419),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text(
              "April 26 , 2023",
              style: TextStyle(
                  color: Colors.white, fontFamily: 'vari', fontSize: 35),
            ),
            Text(
              '$incompletedTasks incomplete, $completedTasks completed',
              style: TextStyle(color: Colors.grey),
            ),
            Divider(),
            SizedBox(height: 20),
            Text(
              'INCOMPLETED',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'vari', fontSize: 20),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: list.tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  if (!(list.tasks[index].completedTask)) {
                    return ListTile(
                      title: Row(
                        children: [
                          Checkbox(
                            side: const BorderSide(color: Colors.white),
                            value: list.tasks[index].ischecked,
                            onChanged: (value) {
                              setState(() {
                                list.tasks[index].ischecked = value!;
                                if (value) {
                                  completedTasks++;
                                  incompletedTasks--;
                                  list.tasks[index].completedTask = value;
                                } else {
                                  completedTasks--;
                                  incompletedTasks++;
                                }
                              });
                            },
                          ),
                          Text(
                            list.tasks[index].task,
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'vari'),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            Text(
              'COMPLETED',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'vari', fontSize: 20),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: list.tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  if (list.tasks[index].completedTask) {
                    return ListTile(
                      title: Row(
                        children: [
                          Checkbox(
                            side: const BorderSide(color: Colors.white),
                            value: list.tasks[index].ischecked,
                            onChanged: (value) {
                              setState(() {
                                list.tasks[index].ischecked = value!;
                                if (value) {
                                  completedTasks++;
                                  incompletedTasks--;
                                  list.tasks[index].completedTask = value;
                                } else {
                                  completedTasks--;
                                  list.delete(list.tasks[index]);
                                }
                              });
                            },
                          ),
                          Text(
                            list.tasks[index].task,
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'vari',
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
