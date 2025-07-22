
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utilities/app_routes.dart';
import 'core/utilities/navigation_service.dart';
import 'features/domain/entities/exercise.dart';
import 'features/presentation/exercise/screen/exercise_home_screen.dart';
import 'features/presentation/exercise/screen/exercise_detail_screen.dart';
import 'features/presentation/exercise/screen/exercise_timer_screen.dart';
import 'features/presentation/exercise/bloc/exercise_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => ExerciseBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        title: 'Workout App',
        initialRoute: AppRoutes.exerciseHome,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case AppRoutes.exerciseHome:
              return MaterialPageRoute(builder: (_) => ExerciseHomeScreen());
            case AppRoutes.exerciseDetail:
              final args = settings.arguments;
              if (args is Exercise) {
                return MaterialPageRoute(
                  builder: (_) => ExerciseDetailScreen(exercise: args),
                );
              } else {
                return MaterialPageRoute(
                  builder:
                      (_) => const Scaffold(
                        body: Center(
                          child: Text(
                            'Invalid or missing arguments for ExerciseDetailScreen',
                          ),
                        ),
                      ),
                );
              }

            case AppRoutes.exerciseTimer:
              return MaterialPageRoute(
                builder: (_) => const ExerciseTimerScreen(),
                settings: settings,
              );
            default:
              return MaterialPageRoute(
                builder:
                    (_) => const Scaffold(
                      body: Center(child: Text('Route not found')),
                    ),
              );
          }
        },
      ),
    );
  }
}
