
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/service/service_locator.dart';
import '../../../domain/repository/exercise_repository.dart';
import 'exercise_event.dart';
import 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final ExerciseRepository _repository = ExerciseRepoProvider.instance;

  ExerciseBloc() : super(ExerciseInitial()) {
    on<LoadExercises>(_onLoadExercises);
    on<MarkExerciseCompleted>(_onMarkCompleted);
  }
Future<void> _onLoadExercises(LoadExercises event, Emitter<ExerciseState> emit) async {
  emit(ExerciseLoading());
  try {
    final exercises = await _repository.getExercises();
    final prefs = await SharedPreferences.getInstance();
    final completedIds = prefs.getStringList('completed_exercises')?.toSet() ?? {};

    final streak = prefs.getInt('streak_count') ?? 0;
    final lastDateStr = prefs.getString('last_completed_date');
    final lastDate = lastDateStr != null ? DateTime.tryParse(lastDateStr) : null;

    emit(ExerciseLoaded(exercises, completedIds, streakCount: streak, lastCompletedDate: lastDate));
  } catch (e) {
    emit(ExerciseError("Something went wrong while fetching exercises."));
  }
}

Future<void> _onMarkCompleted(MarkExerciseCompleted event, Emitter<ExerciseState> emit) async {
  final prefs = await SharedPreferences.getInstance();

  final existing = prefs.getStringList('completed_exercises') ?? [];
  if (!existing.contains(event.exerciseId)) {
    existing.add(event.exerciseId);
    await prefs.setStringList('completed_exercises', existing);
  }

  if (state is ExerciseLoaded) {
    final loadedState = state as ExerciseLoaded;
    final updatedCompleted = {...loadedState.completedIds, event.exerciseId};

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    int newStreak = loadedState.streakCount;
    DateTime? last = loadedState.lastCompletedDate;

    if (last != null) {
      final lastDay = DateTime(last.year, last.month, last.day);
      if (lastDay == today) {
       
      } else if (lastDay == yesterday) {
        newStreak += 1;
      } else {
        newStreak = 1;
      }
    } else {
      newStreak = 1;
    }

    // Save streak and date
    await prefs.setInt('streak_count', newStreak);
    await prefs.setString('last_completed_date', today.toIso8601String());

    emit(ExerciseLoaded(
      loadedState.exercises,
      updatedCompleted,
      streakCount: newStreak,
      lastCompletedDate: today,
    ));
  }
}

}