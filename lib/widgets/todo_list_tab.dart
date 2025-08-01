import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TodoItem {
  final int id;
  final String text;
  final bool isCompleted;
  final DateTime createdAt;

  TodoItem({
    required this.id,
    required this.text,
    required this.isCompleted,
    required this.createdAt,
  });

  TodoItem copyWith({
    int? id,
    String? text,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return TodoItem(
      id: id ?? this.id,
      text: text ?? this.text,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class TodoListTab extends StatefulWidget {
  const TodoListTab({Key? key}) : super(key: key);

  @override
  State<TodoListTab> createState() => _TodoListTabState();
}

class _TodoListTabState extends State<TodoListTab> {
  final List<TodoItem> _todos = [];
  final TextEditingController _textController = TextEditingController();
  bool _isAdding = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _addTodo() {
    if (_textController.text.trim().isEmpty) return;

    setState(() {
      _todos.add(
        TodoItem(
          id: DateTime.now().millisecondsSinceEpoch,
          text: _textController.text.trim(),
          isCompleted: false,
          createdAt: DateTime.now(),
        ),
      );
      _textController.clear();
      _isAdding = false;
    });
  }

  void _toggleTodo(int id) {
    setState(() {
      final index = _todos.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        _todos[index] = _todos[index].copyWith(
          isCompleted: !_todos[index].isCompleted,
        );
      }
    });
  }

  void _deleteTodo(int id) {
    setState(() {
      _todos.removeWhere((todo) => todo.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: _todos.isEmpty ? _buildEmptyState() : _buildTodoList(),
          ),
          if (_isAdding) _buildAddTodoField(),
          _buildFloatingAddButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF4CAF50).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_circle_outline,
              color: Color(0xFF4CAF50),
              size: 24,
            ),
          ),
          SizedBox(width: 12),
          Text(
            'Today\'s Goals',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.close, color: Colors.grey),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.note_add_outlined,
              size: 60,
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'No goals for today yet',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Add your first goal to get started!',
            style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _todos.length,
      itemBuilder: (context, index) {
        final todo = _todos[index];
        return _buildTodoItem(todo);
      },
    );
  }

  Widget _buildTodoItem(TodoItem todo) {
    return Dismissible(
      key: Key(todo.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.delete, color: Colors.red),
      ),
      onDismissed: (_) => _deleteTodo(todo.id),
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: todo.isCompleted ? Color(0xFFE8F5E8) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          leading: GestureDetector(
            onTap: () => _toggleTodo(todo.id),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    todo.isCompleted ? Color(0xFF4CAF50) : Colors.transparent,
                border: Border.all(
                  color: todo.isCompleted ? Color(0xFF4CAF50) : Colors.grey,
                  width: 2,
                ),
              ),
              child:
                  todo.isCompleted
                      ? Icon(Icons.check, size: 16, color: Colors.white)
                      : null,
            ),
          ),
          title: Text(
            todo.text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              decoration:
                  todo.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
              color: todo.isCompleted ? Colors.grey : Colors.black87,
            ),
          ),
          subtitle: Text(
            '${_formatTime(todo.createdAt)}',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: Colors.red.withOpacity(0.7),
            ),
            onPressed: () => _deleteTodo(todo.id),
          ),
        ),
      ),
    );
  }

  Widget _buildAddTodoField() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Add a new goal...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.1),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              onSubmitted: (_) => _addTodo(),
            ),
          ),
          SizedBox(width: 12),
          FloatingActionButton(
            mini: true,
            backgroundColor: Color(0xFF4CAF50),
            child: Icon(Icons.add, color: Colors.white),
            onPressed: _addTodo,
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingAddButton() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          backgroundColor: Color(0xFF4CAF50),
          child: Icon(_isAdding ? Icons.close : Icons.add, color: Colors.white),
          onPressed: () {
            setState(() {
              _isAdding = !_isAdding;
              if (!_isAdding) {
                _textController.clear();
              }
            });
          },
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }
}
