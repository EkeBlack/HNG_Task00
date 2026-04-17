import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;

  const TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkMode ? const Color(0xFF2C2F31) : Colors.white;
    final textColor = isDarkMode ? Colors.white : const Color(0xFF2C2F31);
    final primaryColor = const Color(0xFF145DA2);

    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 16.0),
      child: Dismissible(
        key: Key(taskName),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: cardColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text(
                "Delete Task",
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
              content: Text(
                "Do you want to delete this task?",
                style: TextStyle(color: textColor.withValues(alpha: 0.7)),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("Cancel", style: TextStyle(color: textColor.withValues(alpha: 0.5))),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Okay", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          );
        },
        onDismissed: (direction) {
          deleteFunction?.call(context);
        },
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: Colors.redAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.delete_outline, color: Colors.redAccent),
        ),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: taskCompleted ? primaryColor.withValues(alpha: 0.3) : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              // Checkbox
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: primaryColor,
                  checkColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  side: BorderSide(color: textColor.withValues(alpha: 0.2), width: 1.5),
                ),
              ),

              const SizedBox(width: 12),

              // Task Name
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                    color: taskCompleted ? textColor.withValues(alpha: 0.4) : textColor,
                    fontSize: 16,
                    fontWeight: taskCompleted ? FontWeight.normal : FontWeight.w600,
                    decoration: taskCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
