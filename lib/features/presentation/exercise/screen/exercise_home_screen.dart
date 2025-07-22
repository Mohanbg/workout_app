import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utilities/app_routes.dart' show AppRoutes;
import '../../../../core/utilities/navigation_service.dart';
import '../bloc/exercise_bloc.dart';
import '../bloc/exercise_event.dart';
import '../bloc/exercise_state.dart';
import '../widgets/exercise_card.dart';

class ExerciseHomeScreen extends StatefulWidget {
  const ExerciseHomeScreen({super.key});

  @override
  State<ExerciseHomeScreen> createState() => _ExerciseHomeScreenState();
}

class _ExerciseHomeScreenState extends State<ExerciseHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ExerciseBloc>().add(LoadExercises());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercises')),
      body: BlocBuilder<ExerciseBloc, ExerciseState>(
        builder: (context, state) {
          if (state is ExerciseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExerciseLoaded) {
            return Column(
              children: [
                _buildStreakCard(state.streakCount),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = state.exercises[index];
                      final isCompleted = state.completedIds.contains(
                        exercise.id,
                      );
                      return ExerciseCard(
                        exercise: exercise,
                        isCompleted: isCompleted,
                        onTap: () async {
                          WidgetsBinding.instance.addPostFrameCallback((
                            _,
                          ) async {
                            final result = await NavigationService.pushNamed(
                              AppRoutes.exerciseDetail,
                              arguments: exercise,
                            );

                            if (result == true) {
                              context.read<ExerciseBloc>().add(
                                MarkExerciseCompleted(exercise.id),
                              );
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is ExerciseError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildStreakCard(int streakCount) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_fire_department, color: Colors.orange),
            const SizedBox(width: 8),
            Text(
              'Current Streak: $streakCount day(s)',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
