part of 'task_bloc.dart';
abstract class TaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingState extends TaskState {}

class ErrorState extends TaskState {
  final String errorMessage;

  ErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class LoadedState extends TaskState {
  final List<Task> tasks;

  LoadedState(this.tasks);

  @override
  List<Object?> get props => [tasks];
}
