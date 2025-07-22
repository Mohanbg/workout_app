


import '../../features/data/repository_implementation/exercise_repository_impl.dart';
import '../../features/domain/repository/exercise_repository.dart';

class ExerciseRepoProvider {
  static final ExerciseRepository instance = ExerciseRepositoryImpl();
}