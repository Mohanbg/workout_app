 **App_Overview**:
This is a simple workout Flutter application built using Clean Architecture and BLoC pattern. It displays a list of exercises, shows detailed information for each, and allows the user to start a timer for the selected exercise.

🗂️ Project Folder Structure
```text
lib/
├── core/
│   ├── service/
│   │   └── service_locator.dart         # Dependency injection setup
│   └── utilities/
│       ├── app_routes.dart              # Route definitions
│       └── navigation_service.dart      # Navigation logic using service locator
│
├── features/
│   └── data/
│       ├── model/
│       │   └── exercise_model.dart      # Data model for exercises
│       ├── repository_implementation/
│       │   └── exercise_repository_impl.dart  # Repository implementation (fetching logic)
│
│   └── domain/
│       ├── entities/
│       │   └── exercise.dart            # Entity definition for clean architecture
│       └── repository/
│           └── exercise_repository.dart # Abstract repository definition
│
│   └── presentation/
│       └── exercise/
│           ├── bloc/
│           │   ├── exercise_bloc.dart
│           │   ├── exercise_event.dart
│           │   └── exercise_state.dart  # BLoC pattern for state management
│           ├── cubit/
│           │   └── timer_cubit.dart     # Timer state management
│           ├── screen/
│           │   ├── exercise_detail_screen.dart
│           │   ├── exercise_home_screen.dart
│           │   └── exercise_timer_screen.dart  # UI screens
│           └── widgets/
│               └── exercise_card.dart   # Custom exercise card widget
│
├── main.dart                            # App entry point and MultiBlocProvider setup

```

🚀 **Features**:
Fetches a list of exercises from local JSON or API
Shows exercise name, duration, difficulty, and description
Detail screen with designed UI using Card layout
Exercise timer screen to track progress
Completion tracking using SharedPreferences
BLoC used for state management

🛠️**How to Run the App**:
Make sure Dart and Flutter SDK are installed.
Clone the repository or extract the zipped folder.
Run flutter pub get to install dependencies.
Execute flutter run in terminal or use an IDE like Android Studio or VSCode.

📦 **Dependencies**:
flutter_bloc
equatable
shared_preferences

📘 JSON Format (Sample)
```text
[
  {
    "name": "name 1",
    "description": "description 1",
    "duration": 79,
    "difficulty": "difficulty 1",
    "id": "1"
  },
  {
    "name": "name 2",
    "description": "description 2",
    "duration": 31,
    "difficulty": "difficulty 2",
    "id": "2"
  }
]
```
 **Guidelines**:
-Follow clean architecture principles: Separate UI, business logic, and data layers.
-Use BLoC for scalable and maintainable state management.
-Prefer widgets that are stateless wherever possible.
-All navigation should go through NavigationService.

