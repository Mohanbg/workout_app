import 'package:flutter/material.dart';

import '../../../domain/entities/exercise.dart';



class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final VoidCallback onTap;
  final bool isCompleted;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.onTap,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: isCompleted ? Colors.green[50] : null,
      child: ListTile(
        title: Text(exercise.name),
        subtitle: Text("${exercise.duration} seconds • ${exercise.difficulty}"),
        trailing: isCompleted
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
