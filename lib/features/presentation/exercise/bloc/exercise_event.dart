import 'package:equatable/equatable.dart';

abstract class ExerciseEvent extends Equatable {
  const ExerciseEvent();

  @override
  List<Object?> get props => [];
}

class LoadExercises extends ExerciseEvent {}

class MarkExerciseCompleted extends ExerciseEvent {
  final String exerciseId;

  const MarkExerciseCompleted(this.exerciseId);

  @override
  List<Object?> get props => [exerciseId];
}
