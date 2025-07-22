
import 'package:equatable/equatable.dart';

import '../../../domain/entities/exercise.dart';



abstract class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object?> get props => [];
}

class ExerciseInitial extends ExerciseState {}

class ExerciseLoading extends ExerciseState {}

class ExerciseLoaded extends ExerciseState {
  final List<Exercise> exercises;
  final Set<String> completedIds;
  final int streakCount;
  final DateTime? lastCompletedDate;

  const ExerciseLoaded(
    this.exercises,
    this.completedIds, {
    this.streakCount = 0,
    this.lastCompletedDate,
  });

  ExerciseLoaded copyWith({
    List<Exercise>? exercises,
    Set<String>? completedIds,
    int? streakCount,
    DateTime? lastCompletedDate,
  }) {
    return ExerciseLoaded(
      exercises ?? this.exercises,
      completedIds ?? this.completedIds,
      streakCount: streakCount ?? this.streakCount,
      lastCompletedDate: lastCompletedDate ?? this.lastCompletedDate,
    );
  }

  @override
  List<Object?> get props => [
        exercises,
        completedIds,
        streakCount,
        lastCompletedDate,
      ];
}


class ExerciseError extends ExerciseState {
  final String message;

  const ExerciseError(this.message);

  @override
  List<Object?> get props => [message];
}
