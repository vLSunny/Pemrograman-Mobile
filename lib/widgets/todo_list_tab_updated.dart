import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/todo_model.dart';

class TodoListTabUpdated extends StatefulWidget {
  const TodoListTabUpdated({super.key});

  @override
  State<TodoListTabUpdated> createState() => _TodoListTabUpdatedState();
}

class _TodoListTabUpdatedState extends State<TodoListTabUpdated> {
  List<Todo> todos = [];
  final TextEditingController _todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosJson = prefs.getString('todos');

    if (todosJson != null) {
      final List<dynamic> decoded = jsonDecode(todosJson);
      setState(() {
        todos = decoded.map((item) => Todo.fromMap(item)).toList();
      });
    }
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(
      todos.map((todo) => todo.toMap()).toList(),
    );
    await prefs.setString('todos', encoded);
  }

  void addTodo(String title) {
    if (title.trim().isEmpty) return;

    final newTodo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
      createdAt: DateTime.now(),
    );

    setState(() {
      todos.add(newTodo);
    });

    _saveTodos();
    _todoController.clear();
  }

  void toggleTodo(String id) {
    setState(() {
      final index = todos.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        todos[index] = todos[index].copyWith(
          isCompleted: !todos[index].isCompleted,
          completedAt: !todos[index].isCompleted ? DateTime.now() : null,
        );
      }
    });

    _saveTodos();
  }

  void deleteTodo(String id) {
    setState(() {
      todos.removeWhere((todo) => todo.id == id);
    });

    _saveTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Today's Target",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Add new todo
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                      hintText: 'Add a new task...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: addTodo,
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => addTodo(_todoController.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(12),
                  ),
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),

          // Todo list
          Expanded(
            child:
                todos.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No tasks yet!',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            'Add your first task above',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    )
                    : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];
                        return Card(
                          margin: EdgeInsets.only(bottom: 8),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Checkbox(
                              value: todo.isCompleted,
                              onChanged: (value) => toggleTodo(todo.id),
                              activeColor: Colors.blue[200],
                            ),
                            title: Text(
                              todo.title,
                              style: GoogleFonts.poppins(
                                decoration:
                                    todo.isCompleted
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                color:
                                    todo.isCompleted
                                        ? Colors.grey
                                        : Colors.black,
                              ),
                            ),
                            subtitle:
                                todo.isCompleted && todo.completedAt != null
                                    ? Text(
                                      'Completed ${todo.completedAt!.day}/${todo.completedAt!.month}/${todo.completedAt!.year}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    )
                                    : null,
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () => deleteTodo(todo.id),
                            ),
                          ),
                        );
                      },
                    ),
          ),

          // Summary
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem(
                  'Total',
                  todos.length.toString(),
                  Colors.blue,
                ),
                _buildSummaryItem(
                  'Completed',
                  todos.where((t) => t.isCompleted).length.toString(),
                  Colors.green,
                ),
                _buildSummaryItem(
                  'Pending',
                  todos.where((t) => !t.isCompleted).length.toString(),
                  Colors.orange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }
}
