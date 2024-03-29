# Flutter Task Manager

A powerful and user-friendly task management application built with Flutter and Bloc state management, showcasing clean architecture principles.

## Features

- Create, view, edit, and delete tasks.
- Set due dates and priorities for tasks. (Not implemented yet)
- Mark tasks as completed/incomplete. (Not implemented yet)
- Filter and search for tasks. (Not implemented yet)
- Unit and widget testing for improved code quality.

## Getting Started

### Prerequisites

- Flutter SDK (3.16 or higher): Follow the official installation guide (https://docs.flutter.dev/get-started/install).

### Installation



#### Run below command to generate mocks
```agsl
flutter pub run build_runner build --delete-conflicting-outputs
```

#### Run below command to execute unit testing of Bloc
```agsl
fvm flutter test test/presentation/bloc/task_bloc_test.dart
```

#### Run below command to execute unit testing of UseCases
```agsl
fvm flutter test test/domain/usecases/adding_usecase_test.dart

fvm flutter test test/domain/usecases/fetching_usecase_test.dart

fvm flutter test test/domain/usecases/deleting_usecase_test.dart
```

#### Run below command to execute unit testing of Bloc
```agsl
fvm flutter test test/presentation/widgets/add_task_widget_test.dart
```
