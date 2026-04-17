import 'package:flutter/material.dart';
import 'package:hng_task00/screens/todo_tile.dart';
import '../main.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final _controller = TextEditingController();

  List todoList = [
    ["Buy Groceries", false],
    ["Finish Homework", false],
  ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  void saveNewTask() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        todoList.add([_controller.text.trim(), false]);
        _controller.clear();
      });
      Navigator.of(context).pop();
    }
  }

  void createNewTask() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkMode ? const Color(0xFF2C2F31) : Colors.white;
    final textColor = isDarkMode ? Colors.white : const Color(0xFF2C2F31);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: cardColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Text(
            "New Task",
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          content: TextField(
            controller: _controller,
            autofocus: true,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              hintText: "What's the plan?",
              hintStyle: TextStyle(color: textColor.withValues(alpha: 0.4)),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF145DA2), width: 2),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "CANCEL",
                style: TextStyle(color: textColor.withValues(alpha: 0.5), fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: saveNewTask,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF145DA2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("SAVE"),
            ),
          ],
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDarkMode ? const Color(0xFF1A1C1E) : const Color(0xFFF5F7F9);
    final textColor = isDarkMode ? Colors.white : const Color(0xFF2C2F31);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Todo List',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w900,
            fontSize: 18,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: textColor,
            ),
            onPressed: () {
              themeNotifier.value = isDarkMode ? ThemeMode.light : ThemeMode.dark;
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: const Color(0xFF145DA2),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: todoList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.assignment_turned_in_outlined, size: 80, color: textColor.withValues(alpha: 0.1)),
                  const SizedBox(height: 16),
                  Text(
                    'Precision Planning',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor.withValues(alpha: 0.3)),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: todoList.length,
              itemBuilder: (context, index) {
                return TodoTile(
                  taskName: todoList[index][0],
                  taskCompleted: todoList[index][1],
                  onChanged: (value) => checkBoxChanged(value, index),
                  deleteFunction: (context) => deleteTask(index),
                );
              },
            ),
    );
  }
}
