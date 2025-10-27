import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/tasks.txt');
  }

  var fileData;

  Future<File> writeTasks(String list) async {
    fileData = await _localFile;

    // Write the file

    return fileData.writeAsString(list, mode: FileMode.append);
  }

  showData() async {
    writeTasks(textController.text);
    print(await fileData.readAsString());
  }

  // removeTodo(taskKey) async {
  //   final file = await _localFile;

  //   List filtered = file.writeAsString

  //   setState(() {
  //     taskList = [...filtered];
  //     writeTasks(tasks);
  //   });
  //   showFile();

  // }

  final textController = TextEditingController();

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
        FilledButton(onPressed: showData, child: const Text("add Task")),
        Padding(padding: EdgeInsetsGeometry.all(7)),
      ],
    );
  }
}
