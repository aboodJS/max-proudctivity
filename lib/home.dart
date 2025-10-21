import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        textController.text = '';
        print(tasks);
      }
    });
  }

  final textController = TextEditingController();

  List tasks = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(hintText: "write the task"),
          controller: textController,
        ),
        FilledButton(onPressed: addTodo, child: const Text("add Task")),
        for (int i = 0; i < tasks.length; i++) Text('${i + 1}. ${tasks[i]}'),
      ],
    );
  }
}
