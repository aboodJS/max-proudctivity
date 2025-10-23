import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      home: Scaffold(
        appBar: AppBar(title: Text("testing")),
        body: Column(children: [InputBox()]),
      ),
    );
  }
}

class InputBox extends StatefulWidget {
  const InputBox({super.key});

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  addTodo() {
    setState(() {
      if (textController.text != "") {
        tasks = [...tasks, textController.text];
        saveData();
        textController.text = '';
        print(tasks);
      }
    });
  }

  removeTodo(taskKey) {
    print(taskKey);
    List filtered = tasks.where((element) => element != taskKey).toList();
    print(filtered);

    setState(() {
      tasks = [...filtered];
    });
  }

  saveData() async {
    final prefs = await SharedPreferences.getInstance();

    // Save the counter value to persistent storage under the 'counter' key.
    await prefs.setStringList('tasks', tasks);
  }

  readData() async {
    final prefs = await SharedPreferences.getInstance();

    // Save the counter value to persistent storage under the 'counter' key.
    setState(() {
      tasks = prefs.getStringList('tasks');
    });
  }

  final textController = TextEditingController();

  List<String> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SizedBox(
            width: 300,
            child: TextField(
              decoration: InputDecoration(hintText: "write the task"),
              controller: textController,
            ),
          ),
        ),
        FilledButton(onPressed: addTodo, child: const Text("add Task")),
        Padding(padding: EdgeInsetsGeometry.all(7)),
        for (int i = 0; i < tasks.length; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(key: Key("$i"), '${i + 1}. ${tasks[i]}'),
              FilledButton(
                onPressed: () => removeTodo(tasks[i]),
                child: Text("check task"),
              ),
            ],
          ),
      ],
    );
  }
}
