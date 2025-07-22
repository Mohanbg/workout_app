import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../domain/entities/exercise.dart';
import '../../domain/repository/exercise_repository.dart';
import '../model/exercise_model.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  final String baseUrl = "https://68252ec20f0188d7e72c394f.mockapi.io/dev";

  @override
  Future<List<Exercise>> getExercises() async {
    final res = await http.get(Uri.parse("$baseUrl/workouts"));

    if (res.statusCode == 200) {
      final List list = jsonDecode(res.body);
      return list.map((e) => ExerciseModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load exercises");
    }
  }
}
