import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/exercise.dart';
import '../bloc/exercise_bloc.dart';
import '../bloc/exercise_event.dart';
import '../cubit/timer_cubit.dart';


class ExerciseTimerScreen extends StatelessWidget {
  const ExerciseTimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final exercise = ModalRoute.of(context)!.settings.arguments as Exercise;

    return BlocProvider(
      create: (_) => TimerCubit(exercise.duration),
      child: _ExerciseTimerView(exercise: exercise),
    );
  }
}

class _ExerciseTimerView extends StatelessWidget {
  final Exercise exercise;
  const _ExerciseTimerView({required this.exercise});

  void _showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Completed!'),
        content: const Text('Exercise finished.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); 
              Navigator.pop(context, true); 
            },
            child: const Text('OK'),
          )
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timer')),
      body: BlocConsumer<TimerCubit, int>(
        listener: (context, remaining) {
          if (remaining == 0) {
            context.read<ExerciseBloc>().add(MarkExerciseCompleted(exercise.id));
            _showCompletionDialog(context);
          }
        },
        builder: (context, remaining) {
          return Center(
            child: Text(
              '$remaining seconds left',
              style: const TextStyle(fontSize: 32),
            ),
          );
        },
      ),
    );
  }
}
