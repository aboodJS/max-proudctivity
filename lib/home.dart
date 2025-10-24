import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  showFile() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      print(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/tasks.txt');
  }

  Future<File> writeTasks(List list) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$list');
  }

  addTodo() {
    setState(() {
      if (textController.text != "") {
        tasks = [...tasks, textController.text];
        writeTasks(tasks);
        textController.text = '';
      }
    });
    showFile();
  }

  removeTodo(taskKey) {
    List filtered = tasks.where((element) => element != taskKey).toList();

    setState(() {
      tasks = [...filtered];
    });
  }

  final textController = TextEditingController();

  List tasks = [];

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
        FilledButton(
          onPressed: () {
            addTodo();
          },
          child: const Text("add Task"),
        ),
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
